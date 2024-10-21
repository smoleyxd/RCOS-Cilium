package main

import (
	"crypto/tls"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strconv"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, kTLS testing")
	logRequest(r)
}

func logRequest(r *http.Request) {
	log.Printf("Received request: Method=%s, URL=%s, RemoteAddr=%s, UserAgent=%s", r.Method, r.URL, r.RemoteAddr, r.UserAgent())
}

func main() {
	useKTLS, err := strconv.ParseBool(os.Getenv("USE_KTLS"))
	if err != nil {
		log.Fatalf("Failed to parse USE_KTLS: %v", err)
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/", handler)

	server := &http.Server{
		Addr:    ":8443",
		Handler: mux,
	}

	if useKTLS {
		log.Println("Starting server with kTLS")
		ln, err := net.Listen("tcp", server.Addr)
		if err != nil {
			log.Fatalf("Failed to listen: %v", err)
		}

		tlsListener := tls.NewListener(ln, &tls.Config{
			Certificates: []tls.Certificate{getCertificate()},
			MinVersion:   tls.VersionTLS13,
		})

		log.Println("kTLS server listening on port 8443")
		log.Fatal(server.Serve(tlsListener))
	} else {
		log.Println("Starting server with TLS")
		server.TLSConfig = &tls.Config{
			Certificates: []tls.Certificate{getCertificate()},
			MinVersion:   tls.VersionTLS12,
		}

		log.Println("TLS server listening on port 8443")
		log.Fatal(server.ListenAndServeTLS("cert.pem", "key.pem"))
	}
}

func getCertificate() tls.Certificate {
	cert, err := tls.LoadX509KeyPair("cert.pem", "key.pem")
	if err != nil {
		log.Fatalf("Failed to load certificate: %v", err)
	}
	return cert
}
