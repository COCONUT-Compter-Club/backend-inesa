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

type pengeluaranRepoImpl struct {
}

func NewPengeluaranRepo() PengeluaranRepo {
	return &pengeluaranRepoImpl{}
}

// AddPengeluaran implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) AddPengeluaran(ctx context.Context, tx *sql.Tx, pengeluaran model.Pengeluaran) (model.Pengeluaran, error) {
	idTransaksi := uuid.New().String()

	// Validasi tanggal
	if pengeluaran.Tanggal.IsZero() {
		return pengeluaran, fmt.Errorf("tanggal cannot be zero")
	}

	// Insert ke history_transaksi
	queryTransaksi := `
		INSERT INTO history_transaksi (id_transaksi, tanggal, keterangan, jenis_transaksi, nominal)
		VALUES (?, ?, ?, ?, ?)
	`
	_, err := tx.ExecContext(ctx, queryTransaksi, idTransaksi, pengeluaran.Tanggal, pengeluaran.Keterangan, "Pengeluaran", pengeluaran.Nominal)
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to insert into history_transaksi: %v", err)
	}

	// Insert ke tabel pengeluaran
	queryPengeluaran := `
		INSERT INTO pengeluaran (id_pengeluaran, tanggal, nota, nominal, keterangan, id_transaksi)
		VALUES (?, ?, ?, ?, ?, ?)
	`
	_, err = tx.ExecContext(ctx, queryPengeluaran, pengeluaran.Id, pengeluaran.Tanggal, pengeluaran.Nota, pengeluaran.Nominal, pengeluaran.Keterangan, idTransaksi)
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to insert into pengeluaran: %v", err)
	}

	// Ambil saldo terakhir sebelum tanggal pengeluaran
	var saldoSebelumnya uint64
	querySaldo := `
		SELECT saldo FROM laporan_keuangan 
		WHERE tanggal <= ?
		ORDER BY tanggal DESC
		LIMIT 1
	`
	err = tx.QueryRowContext(ctx, querySaldo, pengeluaran.Tanggal).Scan(&saldoSebelumnya)
	if err != nil && err != sql.ErrNoRows {
		return pengeluaran, fmt.Errorf("failed to fetch previous saldo: %v", err)
	}

	// Hitung saldo baru
	saldoBaru := saldoSebelumnya - pengeluaran.Nominal

	// Insert laporan keuangan baru
	idLaporan := uuid.New().String()
	queryLaporan := `
		INSERT INTO laporan_keuangan 
		(id_laporan, tanggal, keterangan, pemasukan, pengeluaran, saldo, id_transaksi)
		VALUES (?, ?, ?, ?, ?, ?, ?)
	`
	_, err = tx.ExecContext(ctx, queryLaporan, idLaporan, pengeluaran.Tanggal, pengeluaran.Keterangan, 0, pengeluaran.Nominal, saldoBaru, idTransaksi)
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to insert into laporan_keuangan: %v", err)
	}

	// Update saldo semua entri setelah tanggal pengeluaran
	queryUpdate := `
		UPDATE laporan_keuangan
		SET saldo = saldo - ?
		WHERE tanggal > ?
	`
	_, err = tx.ExecContext(ctx, queryUpdate, pengeluaran.Nominal, pengeluaran.Tanggal)
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to update future saldo: %v", err)
	}

	pengeluaran.IdTransaksi = idTransaksi
	return pengeluaran, nil
}

// UpdatePengeluaran implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) UpdatePengeluaran(ctx context.Context, tx *sql.Tx, pengeluaran model.Pengeluaran, id string) (model.Pengeluaran, error) {
	// Pastikan tanggal sudah dalam format time.Time
	if pengeluaran.Tanggal.IsZero() {
		return pengeluaran, fmt.Errorf("tanggal cannot be zero")
	}

	query := "UPDATE pengeluaran SET tanggal = ?, nota = ?, nominal = ?, keterangan = ? WHERE id_pengeluaran = ?"
	_, err := tx.ExecContext(ctx, query, pengeluaran.Tanggal, pengeluaran.Nota, pengeluaran.Nominal, pengeluaran.Keterangan, id)
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to update pengeluaran: %v", err)
	}

	return pengeluaran, nil
}

// GetPengeluaran implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) GetPengeluaran(ctx context.Context, tx *sql.Tx, page int, pageSize int) ([]model.Pengeluaran, int, error) {
	// Hitung offset
	offset := (page - 1) * pageSize

	// Query untuk mendapatkan data dengan pagination
	query := "SELECT id_pengeluaran, tanggal, nota, nominal, keterangan FROM pengeluaran ORDER BY tanggal DESC LIMIT ? OFFSET ?"
	rows, err := tx.QueryContext(ctx, query, pageSize, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to fetch pengeluaran: %v", err)
	}
	defer rows.Close()

	var pengeluaranSlice []model.Pengeluaran
	for rows.Next() {
		pengeluaran := model.Pengeluaran{}
		var tanggalStr string

		err := rows.Scan(&pengeluaran.Id, &tanggalStr, &pengeluaran.Nota, &pengeluaran.Nominal, &pengeluaran.Keterangan)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to scan pengeluaran: %v", err)
		}

		// Parsing string ke time.Time
		pengeluaran.Tanggal, err = time.Parse("2006-01-02 15:04:05", tanggalStr)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to parse tanggal: %v", err)
		}

		pengeluaranSlice = append(pengeluaranSlice, pengeluaran)
	}

	if err = rows.Err(); err != nil {
		return nil, 0, fmt.Errorf("error after iterating rows: %v", err)
	}

	// Query untuk mendapatkan total data
	var total int
	countQuery := "SELECT COUNT(*) FROM pengeluaran"
	err = tx.QueryRowContext(ctx, countQuery).Scan(&total)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to count total pengeluaran: %v", err)
	}

	return pengeluaranSlice, total, nil
}

// FindById implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) FindById(ctx context.Context, tx *sql.Tx, id string) (model.Pengeluaran, error) {
	query := "SELECT id_pengeluaran, tanggal, nota, nominal, keterangan FROM pengeluaran WHERE id_pengeluaran = ?"
	row := tx.QueryRowContext(ctx, query, id)

	pengeluaran := model.Pengeluaran{}
	var tanggalStr string // Simpan tanggal sebagai string terlebih dahulu

	// Scan ke variabel sementara (tanggalStr)
	err := row.Scan(&pengeluaran.Id, &tanggalStr, &pengeluaran.Nota, &pengeluaran.Nominal, &pengeluaran.Keterangan)
	if err != nil {
		if err == sql.ErrNoRows {
			return pengeluaran, fmt.Errorf("pengeluaran not found")
		}
		return pengeluaran, fmt.Errorf("failed to scan pengeluaran: %v", err)
	}

	// Parsing string ke time.Time
	pengeluaran.Tanggal, err = time.Parse("2006-01-02 15:04:05", tanggalStr) // Sesuaikan format dengan data di database
	if err != nil {
		return pengeluaran, fmt.Errorf("failed to parse tanggal: %v", err)
	}

	return pengeluaran, nil
}

// DeletePengeluaran implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) DeletePengeluaran(ctx context.Context, tx *sql.Tx, pengeluaran model.Pengeluaran) (model.Pengeluaran, error) {
    // Validate input
    if pengeluaran.Id == "" {
        return pengeluaran, fmt.Errorf("id_pengeluaran cannot be empty")
    }

    // Fetch id_transaksi, nominal, and tanggal from pengeluaran
    var idTransaksi string
    var nominal int
    var tanggal interface{}
    queryFetch := `
        SELECT id_transaksi, nominal, tanggal 
        FROM pengeluaran 
        WHERE id_pengeluaran = ?
    `
    err := tx.QueryRowContext(ctx, queryFetch, pengeluaran.Id).Scan(&idTransaksi, &nominal, &tanggal)
    if err != nil {
        if err == sql.ErrNoRows {
            return pengeluaran, fmt.Errorf("pengeluaran with id %s not found", pengeluaran.Id)
        }
        return pengeluaran, fmt.Errorf("failed to fetch pengeluaran: %v", err)
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
            return pengeluaran, fmt.Errorf("failed to parse tanggal: %v", err)
        }
        tanggalTime = parsedTime
    default:
        return pengeluaran, fmt.Errorf("unsupported type for tanggal: %T", v)
    }

    // Validate nominal
    if nominal <= 0 {
        return pengeluaran, fmt.Errorf("invalid nominal value: %d", nominal)
    }

    log.Printf("Fetched pengeluaran: id=%s, id_transaksi=%s, nominal=%d, tanggal=%v", pengeluaran.Id, idTransaksi, nominal, tanggalTime)

    // Check if pengeluaran is sufficient
    var minPengeluaran sql.NullInt64
    queryCheck := `
        SELECT MIN(pengeluaran)
        FROM laporan_keuangan
        WHERE tanggal > ?
    `
    err = tx.QueryRowContext(ctx, queryCheck, tanggalTime).Scan(&minPengeluaran)
    if err != nil && err != sql.ErrNoRows {
        return pengeluaran, fmt.Errorf("failed to check pengeluaran: %v", err)
    }
    if minPengeluaran.Valid && minPengeluaran.Int64 < int64(nominal) {
        return pengeluaran, fmt.Errorf("cannot delete: insufficient pengeluaran (%d) for nominal (%d)", minPengeluaran.Int64, nominal)
    }

    // Delete from laporan_keuangan
    queryLaporan := `
        DELETE FROM laporan_keuangan 
        WHERE id_transaksi = ?
    `
    _, err = tx.ExecContext(ctx, queryLaporan, idTransaksi)
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to delete from laporan_keuangan: %v", err)
    }

    // Delete from history_transaksi
    queryHistory := `
        DELETE FROM history_transaksi 
        WHERE id_transaksi = ?
    `
    _, err = tx.ExecContext(ctx, queryHistory, idTransaksi)
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to delete from history_transaksi: %v", err)
    }

    // Delete from pengeluaran
    queryPengeluaran := `
        DELETE FROM pengeluaran 
        WHERE id_pengeluaran = ?
    `
    _, err = tx.ExecContext(ctx, queryPengeluaran, pengeluaran.Id)
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to delete from pengeluaran: %v", err)
    }

    // Update saldo for all records after the deleted pengeluaran's tanggal
    queryUpdateSaldo := `
        UPDATE laporan_keuangan
        SET saldo = saldo + ?
        WHERE tanggal > ?
    `
    result, err := tx.ExecContext(ctx, queryUpdateSaldo, nominal, tanggalTime)
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to update future saldo: %v", err)
    }
    rowsAffected, err := result.RowsAffected()
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to check rows affected for saldo update: %v", err)
    }
    log.Printf("Updated %d rows in laporan_keuangan for saldo with id_pengeluaran %s, nominal %d, tanggal %v", rowsAffected, pengeluaran.Id, nominal, tanggalTime)

    // Update total pengeluaran for all records after the deleted pengeluaran's tanggal
    queryUpdatePengeluaran := `
        UPDATE laporan_keuangan
        SET pengeluaran = GREATEST(0, pengeluaran - ?)
        WHERE tanggal > ?
    `
    result, err = tx.ExecContext(ctx, queryUpdatePengeluaran, nominal, tanggalTime)
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to update future pengeluaran: %v", err)
    }
    rowsAffected, err = result.RowsAffected()
    if err != nil {
        return pengeluaran, fmt.Errorf("failed to check rows affected for pengeluaran update: %v", err)
    }
    log.Printf("Updated %d rows in laporan_keuangan for pengeluaran with id_pengeluaran %s, nominal %d, tanggal %v", rowsAffected, pengeluaran.Id, nominal, tanggalTime)

    return pengeluaran, nil
}

// GetPengeluaranByDateRange implements PengeluaranRepo.
func (s *pengeluaranRepoImpl) GetPengeluaranByDateRange(ctx context.Context, tx *sql.Tx, startDate, endDate string, page int, pageSize int) ([]model.Pengeluaran, int, error) {
	// Hitung offset
	offset := (page - 1) * pageSize

	// Query untuk mendapatkan data dengan pagination dan date range
	query := `
		SELECT id_pengeluaran, tanggal, nota, nominal, keterangan 
		FROM pengeluaran 
		WHERE tanggal BETWEEN ? AND ? 
		ORDER BY tanggal DESC 
		LIMIT ? OFFSET ?
	`
	rows, err := tx.QueryContext(ctx, query, startDate, endDate, pageSize, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to fetch pengeluaran by date range: %v", err)
	}
	defer rows.Close()

	var pengeluaranSlice []model.Pengeluaran
	for rows.Next() {
		pengeluaran := model.Pengeluaran{}
		var tanggalStr string

		err := rows.Scan(&pengeluaran.Id, &tanggalStr, &pengeluaran.Nota, &pengeluaran.Nominal, &pengeluaran.Keterangan)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to scan pengeluaran: %v", err)
		}

		// Parsing string ke time.Time
		pengeluaran.Tanggal, err = time.Parse("2006-01-02 15:04:05", tanggalStr)
		if err != nil {
			return nil, 0, fmt.Errorf("failed to parse tanggal: %v", err)
		}

		pengeluaranSlice = append(pengeluaranSlice, pengeluaran)
	}

	if err = rows.Err(); err != nil {
		return nil, 0, fmt.Errorf("error after iterating rows: %v", err)
	}

	// Query untuk mendapatkan total data dalam rentang tanggal
	var total int
	countQuery := `
		SELECT COUNT(*) 
		FROM pengeluaran 
		WHERE tanggal BETWEEN ? AND ?
	`
	err = tx.QueryRowContext(ctx, countQuery, startDate, endDate).Scan(&total)
	if err != nil {
		return nil, 0, fmt.Errorf("failed to count total pengeluaran in date range: %v", err)
	}

	return pengeluaranSlice, total, nil
}