package main

import "time"

type Message struct {
	Text string `json:"text"`
	Timestamp time.Time `json:"timestamp"`
}

var messages []Message