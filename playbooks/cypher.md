cipher-decoding-tool
A Python script to decode common ciphers like Base64, Caesar Cipher, ROT13, XOR, and Vigenère.

Overview

This repository contains a Python script designed to decode common ciphers, including:

Base64
Caesar Cipher (All Shifts)
ROT13
XOR (with a fixed key)
Vigenère Cipher
It attempts multiple cipher decryption methods and prints the result, making it easier to identify which cipher is used.

Features

Base64 Decoding: Decodes text that has been Base64 encoded.
Caesar Cipher: Attempts all 25 possible shifts to decode Caesar cipher text.
ROT13: Decodes text encoded using the ROT13 method.
XOR Decryption: Decrypts XOR-encrypted text with a fixed key (0x64 by default).
Vigenère Cipher: Decrypts text encrypted with the Vigenère cipher if a key is provided.
Requirements

Python 3.x is required to run the script.
No external libraries are required for basic functionality.
Installation

Clone the repository:

git clone https://github.com/webpro255/cipher-decoding-tool.git
cd cipher-decoding-tool
Make the script executable:

chmod +x decode_ciphers.py
Ensure you have Python 3.x: Check that Python 3.x is installed on your system:

python3 --version
Run the script: You can now run the script directly:

./decode_ciphers.py
Alternatively, you can also run it with Python if it's not marked as executable:

python3 decode_ciphers.py
Usage

Decoding a Message

To decode a message, modify the ciphertext variable in decode_ciphers.py to the encrypted text you want to decipher. If you're using the Vigenère cipher, provide the correct key in the key variable.

Example:

For Base64-encoded text:

ciphertext = "U28gbG9uZyBhcyBpdCBpcyBnb29kIHRvIGJlIG9mIHdoYXQgdGhlIHdvcmxkIHdoZW4gd2Ugd2F0Y2ggYXMgaXQsIHRoZSBhbmltYWwgZ29hbCBpcyB0byBkZWFsIHdpdGggc2VjdXJpdHku"
