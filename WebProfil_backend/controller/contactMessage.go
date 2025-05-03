package controller

import (
    "godesaapps/service"
    "net/http"
    "encoding/json"
    "github.com/julienschmidt/httprouter"
)

type ContactMessageController struct {
    Service service.ContactMessageService
}

func NewContactMessageController(service service.ContactMessageService) *ContactMessageController {
    return &ContactMessageController{
        Service: service,
    }
}

func (c *ContactMessageController) CreateMessage(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
    var req service.ContactMessageRequest
    err := json.NewDecoder(r.Body).Decode(&req)
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    result, err := c.Service.CreateMessage(req)
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(result)
}
