package handlers

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/k-kanke/post_app/backend/db"
	"github.com/k-kanke/post_app/backend/models"
)

func GetPosts(w http.ResponseWriter, r *http.Request) {
	rows, err := db.DB.Query("SELECT id, user_id, text, image_url, created_at FROM posts ORDER BY created_at DESC")
	if err != nil {
		http.Error(w, "DBエラー", http.StatusInternalServerError)
		log.Println("DB Query エラー:", err)
		return
	}
	defer rows.Close()

	var posts []models.Post
	for rows.Next() {
		var p models.Post
		if err := rows.Scan(&p.ID, &p.UserID, &p.Text, &p.ImageURL, &p.CreatedAt); err != nil {
			http.Error(w, "データ取得エラー", http.StatusInternalServerError)
			log.Println("Scan エラー:", err)
			return
		}
		posts = append(posts, p)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(posts)
}

func CreatePost(w http.ResponseWriter, r *http.Request) {
	var p models.Post
	if err := json.NewDecoder(r.Body).Decode(&p); err != nil {
		http.Error(w, "無効なリクエスト", http.StatusBadRequest)
		return
	}

	query := `INSERT INTO posts (user_id, text, image_url) VALUES ($1, $2, $3)`
	_, err := db.DB.Exec(query, p.UserID, p.Text, p.ImageURL)
	if err != nil {
		http.Error(w, "DB挿入エラー", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	fmt.Fprintln(w, "投稿作成成功")
}
