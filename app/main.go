package main

import (
    "encoding/json"
    "net/http"
)

func pingHandler(w http.ResponseWriter, r *http.Request) {
    response := map[string]string{"message": "pong"}
    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(response)
}

func main() {
    http.HandleFunc("/ping", pingHandler)
    http.ListenAndServe(":4000", nil)
}
