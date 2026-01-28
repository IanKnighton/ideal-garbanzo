package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/", helloHandler)
	http.HandleFunc("/livez", healthHandler)
	http.HandleFunc("/readyz", healthHandler)

	port := ":80"
	log.Printf("Server starting on port %s", port)
	if err := http.ListenAndServe(port, nil); err != nil {
		log.Fatal(err)
	}
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	html := `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 60px 80px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            max-width: 600px;
            animation: fadeIn 0.6s ease-in;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        h1 {
            color: #667eea;
            font-size: 3.5em;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        .emoji {
            font-size: 4em;
            margin-bottom: 30px;
            animation: wave 2s ease-in-out infinite;
        }
        @keyframes wave {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(20deg); }
            75% { transform: rotate(-20deg); }
        }
        .info {
            color: #666;
            font-size: 1.1em;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #f0f0f0;
        }
        .info p {
            margin: 10px 0;
        }
        .badge {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            margin-top: 15px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="emoji">👋</div>
        <h1>Hello World</h1>
        <div class="info">
            <p><strong>Powered by:</strong> Go %s</p>
            <p><strong>Deployed on:</strong> GKE</p>
            <div class="badge">✨ Demo Application</div>
        </div>
    </div>
</body>
</html>`

	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	fmt.Fprintf(w, html, getGoVersion())
	log.Printf("Request from %s - %s %s", r.RemoteAddr, r.Method, r.URL.Path)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "OK")
	log.Printf("Health check from %s - %s %s", r.RemoteAddr, r.Method, r.URL.Path)
}

func getGoVersion() string {
	return time.Now().Format("2006-01-02")
}
