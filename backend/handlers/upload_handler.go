package handlers

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
)

func UploadImage(w http.ResponseWriter, r *http.Request) {
	// 最大10MBまで
	r.ParseMultipartForm(10 << 20)

	file, handler, err := r.FormFile("image")
	if err != nil {
		http.Error(w, "画像ファイルの取得に失敗しました", http.StatusBadRequest)
		return
	}
	defer file.Close()

	// 保存先パス
	saveDir := "./uploads"
	os.MkdirAll(saveDir, os.ModePerm)
	filename := fmt.Sprintf("%d_%s", r.ContentLength, handler.Filename)
	savePath := filepath.Join(saveDir, filename)

	out, err := os.Create(savePath)
	if err != nil {
		http.Error(w, "ファイル保存に失敗しました", http.StatusInternalServerError)
		return
	}
	defer out.Close()

	_, err = io.Copy(out, file)
	if err != nil {
		http.Error(w, "保存中にエラーが発生しました", http.StatusInternalServerError)
		return
	}

	// URL返却
	host := r.Host
	imageURL := fmt.Sprintf("http://%s/uploads/%s", host, filename)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, `{"url": "%s"}`, imageURL)
}
