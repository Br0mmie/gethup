package main

import (
	"net/http"
	"strings"
)

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Vary", "Accept")
	header := r.Header.Get("Accept")
	if strings.Contains(header, "html") {
		// return xhtml
		w.Header().Set("Content-Type", "application/xhtml+xml;charset=utf-8")
		http.ServeFile(w, r, "index.xhtml")
	} else {
		// return download
		w.Header().Set("Content-Disposition", `attachment;filename="hostUp.sh"`)
		http.ServeFile(w, r, "hostup.sh")
	}
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
