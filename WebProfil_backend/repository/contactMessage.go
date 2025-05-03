package repository

import (
    "database/sql"
    "godesaapps/model"
)

type ContactMessageRepository interface {
    Create(message model.ContactMessage) (model.ContactMessage, error)
}

type contactMessageRepositoryImpl struct {
    DB *sql.DB
}

func NewContactMessageRepository(db *sql.DB) ContactMessageRepository {
    return &contactMessageRepositoryImpl{DB: db}
}

func (repo *contactMessageRepositoryImpl) Create(message model.ContactMessage) (model.ContactMessage, error) {
    query := "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)"
    result, err := repo.DB.Exec(query, message.Name, message.Email, message.Message)
    if err != nil {
        return model.ContactMessage{}, err
    }

    id, err := result.LastInsertId()
    if err != nil {
        return model.ContactMessage{}, err
    }

    message.ID = int(id)
    return message, nil
}
