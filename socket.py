import socket
import sys
import time

if __name__ == "__main__":
    host = "host.docker.internal"
    port = 8888
    
    try:
        while True:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            try:
                sock.connect((host, port))
                
                while True:
                    data = sock.recv(4096)
                    if not data:
                        print("Connection closed by server")
                        break
                    sock.sendall(data)
            except ConnectionRefusedError:
                print("Connection refused")
                time.sleep(0.1)
            except Exception as e:
                print(f"Error: {e}", file=sys.stderr)
                time.sleep(0.1)
            finally:
                sock.close()
                
    except KeyboardInterrupt:
        print("\nbye")
        sys.exit(0)