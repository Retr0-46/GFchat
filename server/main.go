package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	// Обработка запроса на добавление нового сообщения
	http.HandleFunc("/send_message", addMessageHandler)

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Сервер работает! Перейдите на /send_message для отправки сообщений.")
	})

	// Запуск сервера
	fmt.Println("Server listening port 8000...")
	log.Fatal(http.ListenAndServe("0.0.0.0:8000", nil))
}
