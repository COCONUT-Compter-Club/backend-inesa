package config

import (
    "fmt"
    "log"
    "os"
    "strings"

    "github.com/joho/godotenv"
    "gorm.io/driver/mysql"
    "gorm.io/gorm"
)

func init() {
    err := godotenv.Load()
    if err != nil {
        log.Fatalf("Error loading .env file: %v", err)
    }
}

var DBHost = os.Getenv("DB_HOST")
var DBPort = os.Getenv("DB_PORT")
var AppHost = os.Getenv("APP_HOST")
var AppPort = os.Getenv("APP_PORT")
var User = os.Getenv("DB_USER")
var Pass = os.Getenv("DB_PASSWORD")
var DBName = os.Getenv("DB_NAME")

func ConnectToDatabase() (*gorm.DB, error) {
    // Trim whitespace from environment variables
    dbHost := strings.TrimSpace(DBHost)
    dbPort := strings.TrimSpace(DBPort)
    user := strings.TrimSpace(User)
    pass := strings.TrimSpace(Pass)
    dbName := strings.TrimSpace(DBName)

    if dbHost == "" || dbPort == "" || user == "" || pass == "" || dbName == "" {
        log.Fatal("One or more required environment variables are missing")
    }

    // Format MySQL connection string
    dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True", user, pass, dbHost, dbPort, dbName)
    log.Printf("Connecting to database with: %s", dsn) // Debug log
    db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
    if err != nil {
        log.Fatalf("Failed to open database connection: %v", err)
    }

    return db, nil
}
