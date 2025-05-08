package main

import (
	"log"
	"net/http"

	"github.com/k-kanke/post_app/backend/db"
	"github.com/k-kanke/post_app/backend/handlers"
)

func main() {
	db.Init()

	http.HandleFunc("/posts", func(w http.ResponseWriter, r *http.Request) {
		log.Println("post!!")
		if r.Method == http.MethodGet {
			handlers.GetPosts(w, r)
		} else if r.Method == http.MethodPost {
			log.Println("Create Post呼ばれた!!")
			handlers.CreatePost(w, r)
		} else {
			http.Error(w, "メソッド未対応", http.StatusMethodNotAllowed)
		}
	})

	http.HandleFunc("/upload-image", handlers.UploadImage)
	http.Handle("/uploads/", http.StripPrefix("/uploads/", http.FileServer(http.Dir("./uploads"))))

	log.Println("サーバー起動：http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
