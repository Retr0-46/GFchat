package main

import (
	"encoding/json"
	"net/http"
	"time"
)

func addMessageHandler(w http.ResponseWriter, r *http.Request) {
	// Проверка метода запроса

	w.Header().Set("Access-Control-Allow-Origin", "*")  // Разрешить все источники
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")


	if r.Method != http.MethodPost {
		http.Error(w, "Неверный метод", http.StatusMethodNotAllowed)
		return
	}

	// Декодируем тело запроса в структуру Message
	var newMessage Message
	err := json.NewDecoder(r.Body).Decode(&newMessage)
	if err != nil {
		http.Error(w, "Ошибка декодирования", http.StatusBadRequest)
		return
	}

	// Отправляем ответ клиенту сразу, не дожидаясь горутины
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newMessage)

	// Асинхронная обработка в горутине
	go func() {
		newMessage.Timestamp = time.Now()
		messages = append(messages, newMessage)
	}()
}
