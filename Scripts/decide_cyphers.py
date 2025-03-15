import base64
import string

# Function to decode Base64
def decode_base64(text):
    try:
        decoded = base64.b64decode(text).decode('utf-8')
        return decoded
    except Exception as e:
        return None

# Function to decode Caesar Cipher
def decode_caesar(text, shift):
    decoded = ""
    for char in text:
        if char.isalpha():
            shift_amount = 65 if char.isupper() else 97
            decoded += chr((ord(char) - shift_amount - shift) % 26 + shift_amount)
        else:
            decoded += char
    return decoded

# Function to decode ROT13
def decode_rot13(text):
    return text.translate(str.maketrans('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm'))

# Function to decode XOR (using a fixed key)
def decode_xor(text, key=0x64):
    return ''.join(chr(ord(c) ^ key) for c in text)

# Function to decode Vigenère Cipher
def decode_vigenere(text, key):
    decoded = ""
    key_index = 0
    for char in text:
        if char.isalpha():
            shift = ord(key[key_index % len(key)].upper()) - ord('A')
            if char.isupper():
                decoded += chr((ord(char) - ord('A') - shift) % 26 + ord('A'))
            else:
                decoded += chr((ord(char) - ord('a') - shift) % 26 + ord('a'))
            key_index += 1
        else:
            decoded += char
    return decoded

# Main function to attempt multiple decodings
def attempt_decoding(text, key=None):
    print("Trying Base64...")
    base64_result = decode_base64(text)
    if base64_result:
        print("Base64 Decoded: ", base64_result)
    else:
        print("Base64 failed.")
    
    print("\nTrying Caesar Cipher (All Shifts)...")
    for shift in range(1, 26):
        caesar_result = decode_caesar(text, shift)
        print(f"Shift {shift}: {caesar_result}")
    
    print("\nTrying ROT13...")
    rot13_result = decode_rot13(text)
    print("ROT13 Decoded: ", rot13_result)
    
    print("\nTrying XOR (Key 0x64)...")
    xor_result = decode_xor(text)
    print("XOR Decoded: ", xor_result)
    
    if key:
        print("\nTrying Vigenère Cipher...")
        vigenere_result = decode_vigenere(text, key)
        print("Vigenère Decoded: ", vigenere_result)
    else:
        print("\nNo key provided for Vigenère cipher.")

# Example text (Base64 encoded)
ciphertext = "U28gbG9uZyBhcyBpdCBpcyBnb29kIHRvIGJlIG9mIHdoYXQgdGhlIHdvcmxkIHdoZW4gd2Ugd2F0Y2ggYXMgaXQsIHRoZSBhbmltYWwgZ29hbCBpcyB0byBkZWFsIHdpdGggc2VjdXJpdHku"  # Base64 of "So long as it is good to be of what the world when we watch as it, the animal goal is to deal with security."

# Attempt decoding
key = "KEY"  # Key for Vigenère cipher if needed
attempt_decoding(ciphertext, key)