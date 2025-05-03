package dto

type ContactMessageRequest struct {
    Name    string `json:"name" validate:"required"`
    Email   string `json:"email" validate:"required,email"`
    Subject string `json:"subject"`
    Message string `json:"message" validate:"required"`
}

type ContactMessageResponse struct {
    ID      uint   `json:"id"`
    Name    string `json:"name"`
    Email   string `json:"email"`
    Subject string `json:"subject"`
    Message string `json:"message"`
}


