# minitalk
![Language](https://img.shields.io/badge/Language-C-blue)
![Score](https://img.shields.io/badge/Score-125%2F100-brightgreen)

<p>A small client-server communication system using UNIX signals.

---

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
- [Author](#author)

---

## Overview
minitalk is a 42 project designed to make processes communicate through the use of user-defined signals (SIGUSR1 and SIGUSR2). These signals are used to send bits from one process to the other and are then interpreted to rebuild the message.

## Usage
Run `make` to get the executables.

1. **Start the server:**
```bash
./server
```
It will print its PID. Keep it.

2. **Send a message:**
```bash
./client [PID] "Hello world"
```

3. **Result:**
```bash
$ ./server
PID: 30541
Hello world
```
## Author
- **Name:** Daniel Zamora
- **GitHub:** [tekuron](https://github.com/tekuron)
- **42 Intra:** [danzamor](https://profile-v3.intra.42.fr/users/danzamor)
- **School:** 42
