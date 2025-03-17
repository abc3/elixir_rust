import sys
import time

if __name__ == "__main__":
    sys.stdout.flush()
    try:
        while True:
            line = sys.stdin.readline()
            if not line:
                continue
            sys.stdout.write(line)
            sys.stdout.flush()
    except KeyboardInterrupt:
        print("\nbye")
