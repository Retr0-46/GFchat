package main

import (
	"log"
	"net/http"

	"server/db"
	"server/handlers"
)

func main() {
	db.Init()

	http.HandleFunc("/register", handlers.Register)
	http.HandleFunc("/login", handlers.Login)
	http.HandleFunc("/ws", handlers.WebSocketHandler)

	log.Println("Запущен сервер на http://localhost:8080 ...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
