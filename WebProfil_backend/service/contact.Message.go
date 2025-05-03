package service

import (
    "godesaapps/model"
    "godesaapps/repository"
)

type ContactMessageRequest struct {
    Name    string `json:"name"`
    Email   string `json:"email"`
    Message string `json:"message"`
}

type ContactMessageService interface {
    CreateMessage(req ContactMessageRequest) (model.ContactMessage, error)
}

type contactMessageServiceImpl struct {
    Repo repository.ContactMessageRepository
}

func NewContactMessageService(repo repository.ContactMessageRepository) ContactMessageService {
    return &contactMessageServiceImpl{Repo: repo}
}

func (s *contactMessageServiceImpl) CreateMessage(req ContactMessageRequest) (model.ContactMessage, error) {
    message := model.ContactMessage{
        Name:    req.Name,
        Email:   req.Email,
        Message: req.Message,
    }

    return s.Repo.Create(message)
}
