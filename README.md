# 🐧 Arch Linux Dev Container with AUR Support

[![Docker](https://img.shields.io/badge/built%20with-Docker-blue)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Este projeto fornece uma imagem Docker baseada no Arch Linux, ideal para ambientes de desenvolvimento avançados com suporte ao AUR via `yay`.

---

## 🚀 Recursos

- Base em `archlinux:latest`
- Suporte completo ao [AUR (Arch User Repository)](https://aur.archlinux.org/)
- Instalação automática de pacotes definidos em um arquivo remoto (dotfiles)
- Ferramentas essenciais como `aws-cli`, `yq`, `unzip` e `sudo` já incluídas
- Labels OCI compatíveis para rastreabilidade de builds

---

## 📦 Pacotes Instalados

A imagem instala:

- `yay` (helper para AUR)
- `sudo`, `yq`, `which`, `unzip`
- Pacotes definidos em:  
  `https://raw.githubusercontent.com/cleicastro/dotfiles/main/vars/main.yml`
- `aws-cli`

---

## 🛠️ Como usar

```bash
docker build -t arch-dev \
  --build-arg REPO_OWNER=cleicastro \
  --build-arg REPO_NAME=archlinux-dev-container \
  --build-arg VERSION=1.0.0 \
  --build-arg GIT_COMMIT_SHA=$(git rev-parse HEAD) \
  --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  .
