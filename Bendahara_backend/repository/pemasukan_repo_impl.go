package repository

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/google/uuid"
	"github.com/syrlramadhan/api-bendahara-inovdes/model"
)

type pemasukanRepoImpl struct {
}

func NewPemasukanRepo() PemasukanRepo {
	return &pemasukanRepoImpl{}
}

// AddPemasukan implements PemasukanRepo.
func (s *pemasukanRepoImpl) AddPemasukan(ctx context.Context, tx *sql.Tx, pemasukan model.Pemasukan) (model.Pemasukan, error) {
	idTransaksi := uuid.New().String()

	// Validasi tanggal
	if pemasukan.Tanggal.IsZero() {
		return pemasukan, fmt.Errorf("tanggal cannot be zero")
	}

	// Insert ke history_transaksi
	queryTransaksi := `
		INSERT INTO history_transaksi (id_transaksi, tanggal, keterangan, jenis_transaksi, nominal) 
		VALUES (?, ?, ?, ?, ?)
	`
	_, err := tx.ExecContext(ctx, queryTransaksi, idTransaksi, pemasukan.Tanggal, pemasukan.Keterangan, "Pemasukan", pemasukan.Nominal)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to insert into history_transaksi: %v", err)
	}

	// Insert ke tabel pemasukan
	queryPemasukan := `
		INSERT INTO pemasukan (id_pemasukan, tanggal, kategori, keterangan, nominal, nota, id_transaksi) 
		VALUES (?, ?, ?, ?, ?, ?, ?)
	`
	_, err = tx.ExecContext(ctx, queryPemasukan, pemasukan.Id, pemasukan.Tanggal, pemasukan.Kategori, pemasukan.Keterangan, pemasukan.Nominal, pemasukan.Nota, idTransaksi)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to insert into pemasukan: %v", err)
	}

	// Ambil saldo terakhir sebelum tanggal pemasukan
	var saldoSebelumnya uint64
	querySaldo := `
		SELECT saldo FROM laporan_keuangan 
		WHERE tanggal <= ?
		ORDER BY tanggal DESC
		LIMIT 1
	`
	err = tx.QueryRowContext(ctx, querySaldo, pemasukan.Tanggal).Scan(&saldoSebelumnya)
	if err != nil && err != sql.ErrNoRows {
		return pemasukan, fmt.Errorf("failed to fetch previous saldo: %v", err)
	}

	// Hitung saldo baru
	saldoBaru := saldoSebelumnya + pemasukan.Nominal

	// Insert laporan keuangan baru
	idLaporan := uuid.New().String()
	queryLaporan := `
		INSERT INTO laporan_keuangan 
		(id_laporan, tanggal, keterangan, pemasukan, pengeluaran, saldo, id_transaksi)
		VALUES (?, ?, ?, ?, ?, ?, ?)
	`
	_, err = tx.ExecContext(ctx, queryLaporan, idLaporan, pemasukan.Tanggal, pemasukan.Keterangan, pemasukan.Nominal, 0, saldoBaru, idTransaksi)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to insert into laporan_keuangan: %v", err)
	}

	// Update saldo semua entri setelah tanggal pemasukan
	queryUpdate := `
		UPDATE laporan_keuangan
		SET saldo = saldo + ?
		WHERE tanggal > ?
	`
	_, err = tx.ExecContext(ctx, queryUpdate, pemasukan.Nominal, pemasukan.Tanggal)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to update future saldo: %v", err)
	}

	pemasukan.IdTransaksi = idTransaksi
	return pemasukan, nil
}

// UpdatePemasukan implements PemasukanRepo.
func (s *pemasukanRepoImpl) UpdatePemasukan(ctx context.Context, tx *sql.Tx, pemasukan model.Pemasukan, id string) (model.Pemasukan, error) {
	// Pastikan tanggal sudah dalam format time.Time
	if pemasukan.Tanggal.IsZero() {
		return pemasukan, fmt.Errorf("tanggal cannot be zero")
	}

	query := "UPDATE pemasukan SET tanggal = ?, kategori = ?, keterangan = ?, nominal = ?, nota = ? WHERE id_pemasukan = ?"
	_, err := tx.ExecContext(ctx, query, pemasukan.Tanggal, pemasukan.Kategori, pemasukan.Keterangan, pemasukan.Nominal, pemasukan.Nota, id)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to update pemasukan: %v", err)
	}

	return pemasukan, nil
}

// GetPemasukan implements PemasukanRepo.
func (s *pemasukanRepoImpl) GetPemasukan(ctx context.Context, tx *sql.Tx, page int, pageSize int) ([]model.Pemasukan, int, error) {
	// Hitung offset
	offset := (page - 1) * pageSize

	// Query untuk mendapatkan data dengan pagination
	query := "SELECT id_pemasukan, tanggal, kategori, keterangan, nominal, nota FROM pemasukan ORDER BY tanggal DESC LIMIT ? OFFSET ?"
	rows, err := tx.QueryContext(ctx, query, pageSize, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to fetch pemasukan: %v", err)
	}
	defer rows.Close()

	var pemasukanSlice []model.Pemasukan
	for rows.Next() {
		pemasukan := model.Pemasukan{}
		var tanggal interface{}

		err := rows.Scan(&pemasukan.Id, &tanggal, &pemasukan.Kategori, &pemasukan.Keterangan, &pemasukan.Nominal, &pemasukan.Nota)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to scan pemasukan: %v", err)
		}

		switch v := tanggal.(type) {
		case time.Time:
			pemasukan.Tanggal = v
		case []byte:
			tanggalStr := string(v)
			parsedTime, err := time.Parse("2006-01-02 15:04:05", tanggalStr)
			if err != nil {
				return nil, 0, fmt.Errorf("failed to parse tanggal: %v", err)
			}
			pemasukan.Tanggal = parsedTime
		default:
			return nil, 0, fmt.Errorf("unsupported type for tanggal: %T", v)
		}

		pemasukanSlice = append(pemasukanSlice, pemasukan)
	}

	if err = rows.Err(); err != nil {
		return nil, 0, fmt.Errorf("error after iterating rows: %v", err)
	}

	// Query untuk mendapatkan total data
	var total int
	countQuery := "SELECT COUNT(*) FROM pemasukan"
	err = tx.QueryRowContext(ctx, countQuery).Scan(&total)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to count total pemasukan: %v", err)
	}

	return pemasukanSlice, total, nil
}

// FindById implements PemasukanRepo.
func (s *pemasukanRepoImpl) FindById(ctx context.Context, tx *sql.Tx, id string) (model.Pemasukan, error) {
	query := "SELECT id_pemasukan, tanggal, kategori, keterangan, nominal, nota FROM pemasukan WHERE id_pemasukan = ?"
	row := tx.QueryRowContext(ctx, query, id)

	pemasukan := model.Pemasukan{}
	var tanggal interface{} // Simpan tanggal sebagai interface{} untuk debugging

	// Scan ke variabel interface{}
	err := row.Scan(&pemasukan.Id, &tanggal, &pemasukan.Kategori, &pemasukan.Keterangan, &pemasukan.Nominal, &pemasukan.Nota)
	if err != nil {
		if err == sql.ErrNoRows {
			return pemasukan, fmt.Errorf("pemasukan not found")
		}
		return pemasukan, fmt.Errorf("failed to scan pemasukan: %v", err)
	}

	// Konversi manual jika diperlukan
	switch v := tanggal.(type) {
	case time.Time:
		pemasukan.Tanggal = v
	case []byte:
		// Jika tanggal adalah []byte, parse ke time.Time
		tanggalStr := string(v)
		parsedTime, err := time.Parse("2006-01-02 15:04:05", tanggalStr)
		if err != nil {
			return pemasukan, fmt.Errorf("failed to parse tanggal: %v", err)
		}
		pemasukan.Tanggal = parsedTime
	default:
		return pemasukan, fmt.Errorf("unsupported type for tanggal: %T", v)
	}

	return pemasukan, nil
}

// DeletePemasukan implements PemasukanRepo.
func (s *pemasukanRepoImpl) DeletePemasukan(ctx context.Context, tx *sql.Tx, pemasukan model.Pemasukan) (model.Pemasukan, error) {
	// Validate input
	if pemasukan.Id == "" {
		return pemasukan, fmt.Errorf("id_pemasukan cannot be empty")
	}

	// Fetch id_transaksi, nominal, and tanggal from pemasukan
	var idTransaksi string
	var nominal int
	var tanggal interface{}
	queryFetch := `
		SELECT id_transaksi, nominal, tanggal 
		FROM pemasukan 
		WHERE id_pemasukan = ?
	`
	err := tx.QueryRowContext(ctx, queryFetch, pemasukan.Id).Scan(&idTransaksi, &nominal, &tanggal)
	if err != nil {
		if err == sql.ErrNoRows {
			return pemasukan, fmt.Errorf("pemasukan with id %s not found", pemasukan.Id)
		}
		return pemasukan, fmt.Errorf("failed to fetch pemasukan: %v", err)
	}

	// Convert tanggal to time.Time
	var tanggalTime time.Time
	switch v := tanggal.(type) {
	case time.Time:
		tanggalTime = v
	case []byte:
		tanggalStr := string(v)
		parsedTime, err := time.Parse("2006-01-02 15:04:05", tanggalStr)
		if err != nil {
			return pemasukan, fmt.Errorf("failed to parse tanggal: %v", err)
		}
		tanggalTime = parsedTime
	default:
		return pemasukan, fmt.Errorf("unsupported type for tanggal: %T", v)
	}

	// Validate nominal
	if nominal <= 0 {
		return pemasukan, fmt.Errorf("invalid nominal value: %d", nominal)
	}

	log.Printf("Fetched pemasukan: id=%s, id_transaksi=%s, nominal=%d, tanggal=%v", pemasukan.Id, idTransaksi, nominal, tanggalTime)

	// Delete from laporan_keuangan
	queryLaporan := `
		DELETE FROM laporan_keuangan 
		WHERE id_transaksi = ?
	`
	_, err = tx.ExecContext(ctx, queryLaporan, idTransaksi)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to delete from laporan_keuangan: %v", err)
	}

	// Delete from history_transaksi
	queryHistory := `
		DELETE FROM history_transaksi 
		WHERE id_transaksi = ?
	`
	_, err = tx.ExecContext(ctx, queryHistory, idTransaksi)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to delete from history_transaksi: %v", err)
	}

	// Delete from pemasukan
	queryPemasukan := `
		DELETE FROM pemasukan 
		WHERE id_pemasukan = ?
	`
	_, err = tx.ExecContext(ctx, queryPemasukan, pemasukan.Id)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to delete from pemasukan: %v", err)
	}

	// Update saldo for all records after the deleted pemasukan's tanggal
	queryUpdateSaldo := `
		UPDATE laporan_keuangan
		SET saldo = saldo - ?
		WHERE tanggal > ?
	`
	result, err := tx.ExecContext(ctx, queryUpdateSaldo, nominal, tanggalTime)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to update future saldo: %v", err)
	}
	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return pemasukan, fmt.Errorf("failed to check rows affected for saldo update: %v", err)
	}
	log.Printf("Updated %d rows in laporan_keuangan for saldo with id_pemasukan %s, nominal %d, tanggal %v", rowsAffected, pemasukan.Id, nominal, tanggalTime)

	// Update total pemasukan for all records after the deleted pemasukan's tanggal
	queryUpdatePemasukan := `
		UPDATE laporan_keuangan
		SET pemasukan = pemasukan - ?
		WHERE tanggal > ?
	`
	result, err = tx.ExecContext(ctx, queryUpdatePemasukan, nominal, tanggalTime)
	if err != nil {
		return pemasukan, fmt.Errorf("failed to update future pemasukan: %v", err)
	}
	rowsAffected, err = result.RowsAffected()
	if err != nil {
		return pemasukan, fmt.Errorf("failed to check rows affected for pemasukan update: %v", err)
	}
	log.Printf("Updated %d rows in laporan_keuangan for pemasukan with id_pemasukan %s, nominal %d, tanggal %v", rowsAffected, pemasukan.Id, nominal, tanggalTime)

	return pemasukan, nil
}

// GetPemasukanByDateRange implements PemasukanRepo.
func (s *pemasukanRepoImpl) GetPemasukanByDateRange(ctx context.Context, tx *sql.Tx, startDate, endDate string, page int, pageSize int) ([]model.Pemasukan, int, error) {
	// Hitung offset
	offset := (page - 1) * pageSize

	// Query untuk mendapatkan data dengan pagination dan date range
	query := `
		SELECT id_pemasukan, tanggal, kategori, keterangan, nominal, nota 
		FROM pemasukan 
		WHERE tanggal BETWEEN ? AND ? 
		ORDER BY tanggal DESC 
		LIMIT ? OFFSET ?
	`
	rows, err := tx.QueryContext(ctx, query, startDate, endDate, pageSize, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to fetch pemasukan by date range: %v", err)
	}
	defer rows.Close()

	var pemasukanSlice []model.Pemasukan
	for rows.Next() {
		pemasukan := model.Pemasukan{}
		var tanggal interface{}

		err := rows.Scan(&pemasukan.Id, &tanggal, &pemasukan.Kategori, &pemasukan.Keterangan, &pemasukan.Nominal, &pemasukan.Nota)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to scan pemasukan: %v", err)
		}

		switch v := tanggal.(type) {
		case time.Time:
			pemasukan.Tanggal = v
		case []byte:
			tanggalStr := string(v)
			parsedTime, err := time.Parse("2006-01-02 15:04:05", tanggalStr)
			if err != nil {
				return nil, 0, fmt.Errorf("failed to parse tanggal: %v", err)
			}
			pemasukan.Tanggal = parsedTime
		default:
			return nil, 0, fmt.Errorf("unsupported type for tanggal: %T", v)
		}

		pemasukanSlice = append(pemasukanSlice, pemasukan)
	}

	if err = rows.Err(); err != nil {
		return nil, 0, fmt.Errorf("error after iterating rows: %v", err)
	}

	// Query untuk mendapatkan total data dalam rentang tanggal
	var total int
	countQuery := `
		SELECT COUNT(*) 
		FROM pemasukan 
		WHERE tanggal BETWEEN ? AND ?
	`
	err = tx.QueryRowContext(ctx, countQuery, startDate, endDate).Scan(&total)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to count total pemasukan in date range: %v", err)
	}

	return pemasukanSlice, total, nil
}