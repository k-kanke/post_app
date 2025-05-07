package main

import (
	"log"
	"net/http"

	"github.com/k-kanke/post_app/backend/db"
	"github.com/k-kanke/post_app/backend/handlers"
)

func main() {
	db.Init()

	http.HandleFunc("/posts", handlers.GetPosts)

	log.Println("サーバー起動：http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
