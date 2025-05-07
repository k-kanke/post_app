package db

import (
	"database/sql"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

var DB *sql.DB

func Init() {
	_ = godotenv.Load()
	dsn := os.Getenv("DATABASE_URL")

	var err error
	DB, err = sql.Open("postgres", dsn)
	if err != nil {
		log.Fatal("DB接続エラー:", err)
	}

	if err = DB.Ping(); err != nil {
		log.Fatal("DB接続確認エラー:", err)
	}

	log.Println("DB接続成功")
}
