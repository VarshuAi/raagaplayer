import os

def find_flutter():
    search_paths = [
        "C:\\src\\flutter\\bin\\flutter.bat",
        "C:\\flutter\\bin\\flutter.bat",
        "C:\\Users\\varshan\\flutter\\bin\\flutter.bat",
        "C:\\Users\\varshan\\AppData\\Local\\Flutter\\bin\\flutter.bat",
        "C:\\tools\\flutter\\bin\\flutter.bat",
        "C:\\Users\\varshan\\src\\flutter\\bin\\flutter.bat",
    ]
    
    # Check if there is a flutter on Path or registry
    for path in search_paths:
        if os.path.exists(path):
            print("Found Flutter:", path)
            return path
            
    # Do a quick search on User directory
    user_dir = os.path.expanduser("~")
    for root, dirs, files in os.walk(user_dir):
        if "flutter.bat" in files:
            p = os.path.join(root, "flutter.bat")
            print("Found Flutter in user directory:", p)
            return p
        # Limit search depth to avoid hanging
        if root.count(os.sep) - user_dir.count(os.sep) > 3:
            dirs.clear()
            
    print("Flutter not found in default paths.")
    return None

if __name__ == "__main__":
    find_flutter()
