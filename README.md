# Lightweight Encryption based on One Time Passwords

This is code for research purposes (such as performance measurements, etc). However, this is not meant to be used in production environments.

# Compiling

## Configuration
Some parameters can be modified by setting variables needed for the application can be found in the file **config.h**
To main.c application registers clients to the server and sets the keys for the client in a deterministic way for demo purposes.

This repository's main file compiles two different console-based applications, namely a client and a server.

### Compile client
To compile the client application for generating root secrets and encrypting messages use the command
`make PART=client`
As the client is build by default you could just use a simple `make` as well.

### Compile server
To compile the server application for maintaining client information and decrypting messages use the command
`make PART=server`

# Quick Bash Test

To test the client and server after they have been built you can pipe the inputs like this to generate N messages:
```
N=100
seq $N|  ./client/client.out $N | grep encrypted | awk '{print $6}'|./server/server.out $N
```
