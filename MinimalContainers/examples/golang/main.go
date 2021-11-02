package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/kittens", handleKitten)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handleKitten(w http.ResponseWriter, r *http.Request) {
	kitten := Kitten{
		Name: "Garfield",
	}

	w.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(w).Encode(kitten)
}
