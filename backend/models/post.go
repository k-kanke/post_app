package models

type Post struct {
	ID        int    `json:"id"`
	UserID    int    `json:"user_id"`
	Text      string `json:"text"`
	ImageURL  string `json:"image_url"`
	CreatedAt string `json:"created_at"`
}
