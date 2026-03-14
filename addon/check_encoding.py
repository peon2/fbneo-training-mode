import sys

filename = r'c:\Users\usuario\Documents\Fightcade\emulator\fbneo\fbneo-training-mode\addon\kof_training_move_data.lua'

try:
    with open(filename, 'rb') as f:
        header = f.read(4)
        if header.startswith(b'\xef\xbb\xbf'):
            print("Found UTF-8 BOM")
        elif header.startswith(b'\xfe\xff'):
            print("Found UTF-16 BE BOM")
        elif header.startswith(b'\xff\xfe'):
            print("Found UTF-16 LE BOM")
        else:
            print("No BOM found")

    with open(filename, 'r', encoding='utf-8', errors='replace') as f:
        for i, line in enumerate(f, 1):
            for char in line:
                if ord(char) > 127:
                    print(f"Non-ASCII character '{char}' (ord {ord(char)}) found at line {i}")
                    break # Only show first non-ASCII per line
except Exception as e:
    print(f"Error: {e}")
