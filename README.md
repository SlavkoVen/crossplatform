# Multiplatform Testing

This repository contains examples of a **Makefile** and a **Dockerfile** for building and testing product code on multiple platforms and architectures (Linux, macOS, Windows, ARM).

## 📂 Structure
- `Makefile` – provides targets to build the code for different platforms and architectures.  
- `Dockerfile` – describes a container for running the test suite using the base image [quay.io/projectquay/golang](https://quay.io/repository/projectquay/golang).

## ⚙️ Usage

### Build the code
Use `make` to build for a specific target platform:

```bash
make linux
make macos
make windows
make arm
