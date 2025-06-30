package handlers

import (
	"log"
	"net/http"
	"sync"

	"github.com/gorilla/websocket"
	"server/db"
)

// Структура входящего сообщения
type WSMessage struct {
	Sender   string `json:"sender"`
	Receiver string `json:"receiver"`
	Content  string `json:"content"`
}

// WebSocket апгрейдер
var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true // Разрешаем соединения отовсюду (для отладки)
	},
}

// Карта активных соединений: login -> WebSocket-соединение
var clients = make(map[string]*websocket.Conn)
var mu sync.Mutex // чтобы избежать гонки при доступе к clients

func WebSocketHandler(w http.ResponseWriter, r *http.Request) {
	// Получаем логин из query-параметра
	login := r.URL.Query().Get("login")
	if login == "" {
		http.Error(w, "Login required", http.StatusBadRequest)
		return
	}

	// Апгрейд обычного HTTP соединения до WebSocket
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("Ошибка при апгрейде WebSocket:", err)
		return
	}
	defer conn.Close()

	// Сохраняем пользователя
	mu.Lock()
	clients[login] = conn
	mu.Unlock()
	log.Printf("%s подключён через WebSocket", login)

	for {
		// Читаем входящее сообщение
		var msg WSMessage
		err := conn.ReadJSON(&msg)
		if err != nil {
			log.Printf("Ошибка чтения от %s: %v", login, err)
			break
		}

		log.Printf("Сообщение от %s к %s: %s", msg.Sender, msg.Receiver, msg.Content)

		// Сохраняем сообщение в базу
		saveMessage(msg)

		// Пересылаем получателю
		mu.Lock()
		receiverConn, ok := clients[msg.Receiver]
		mu.Unlock()

		if ok {
			// Получатель в сети — пересылаем сообщение
			err := receiverConn.WriteJSON(msg)
			if err != nil {
				log.Printf("Ошибка отправки сообщению %s: %v", msg.Receiver, err)
			}
		} else {
			log.Printf("%s не в сети — сообщение сохранено", msg.Receiver)
		}
	}

	// Удаляем пользователя из clients при отключении
	mu.Lock()
	delete(clients, login)
	mu.Unlock()
	log.Printf("%s отключён", login)
}

// Сохраняет сообщение в SQLite
func saveMessage(msg WSMessage) {
	_, err := db.DB.Exec(`
		INSERT INTO messages(sender, receiver, content)
		VALUES (?, ?, ?)`,
		msg.Sender, msg.Receiver, msg.Content)

	if err != nil {
		log.Println("Ошибка сохранения сообщения в БД:", err)
	}
}
