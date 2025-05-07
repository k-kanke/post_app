package handlers

import (
	"encoding/json"
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
