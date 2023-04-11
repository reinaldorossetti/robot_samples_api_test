import os
from cryptography.hazmat.primitives.ciphers.aead import AESCCM
from cryptography.hazmat.backends import default_backend


def aes_crypto(name):
    # Use a breakpoint in the code line below to debug your script.
    data = b"a secret message"
    aad = b"authenticated but unencrypted data"
    key = AESCCM.generate_key(128)
    chacha = AESCCM(key)
    nonce = os.urandom(12)
    textCrypto = chacha.encrypt(nonce, data, aad)
    print(textCrypto)
    text = chacha.decrypt(nonce, textCrypto, aad)
    print(text)


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    aes_crypto('PyCharm')