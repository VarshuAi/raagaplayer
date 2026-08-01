import urllib.request
import json

def test_health():
    try:
        response = urllib.request.urlopen("http://localhost:8000/health", timeout=2)
        data = json.loads(response.read().decode())
        print("Health status:", data)
    except Exception as e:
        print("Health test failed:", e)

if __name__ == "__main__":
    test_health()
