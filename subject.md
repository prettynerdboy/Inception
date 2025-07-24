# Inception

**Version: 3.2**  
**Summary**: This document is a System Administration related exercise.

---

## 📑 Contents

1. [Preamble](#preamble)  
2. [Introduction](#introduction)  
3. [General Guidelines](#general-guidelines)  
4. [Mandatory Part](#mandatory-part)  
5. [Bonus Part](#bonus-part)  
6. [Submission and Peer Evaluation](#submission-and-peer-evaluation)  

---

## 🧾 Preamble

---

## 🎯 Introduction

This project aims to broaden your knowledge of system administration through the use of Docker technology.  
You will virtualize several Docker images by creating them in your new personal virtual machine.

---

## ⚙️ General Guidelines

- This project must be completed on a Virtual Machine.
- All configuration files must be placed in a `srcs/` folder.
- A `Makefile` is required at the root to build everything using `docker-compose.yml`.
- You are expected to explore Docker documentation and related resources to complete this project.

---

## 🚧 Mandatory Part

You must set up a small infrastructure with multiple services under strict rules:

- Each Docker image must be named after its service.
- Each service must run in its **own container**.
- Use **Alpine** or **Debian** (penultimate stable version) as base images.
- No pulling pre-built images (except Alpine/Debian).
- Write your own Dockerfiles.
- Build images via the `Makefile` using `docker-compose.yml`.

### Required services:

- NGINX container with **TLSv1.2 or TLSv1.3**.
- WordPress container with **php-fpm**, no NGINX.
- MariaDB container, no NGINX.
- One volume for WordPress **database**.
- One volume for WordPress **site files**.
- Docker network connecting all containers.

### Constraints:

- Containers must restart automatically after a crash.
- No `tail -f`, `bash`, `sleep infinity`, `while true`, etc.
- Avoid using `network: host`, `--link`, `links:`.

### WordPress DB:

- Must contain **two users**, including an **administrator**.
- The admin username **must not contain**: `admin`, `administrator`, `Admin`, etc.

### Volumes:

- Available under `/home/login/data` on host.
- Use your actual 42 login (e.g., `wil.42.fr`).

### Environment:

- Use `.env` file and Docker secrets for sensitive info.
- **No passwords** hardcoded in Dockerfiles.
- The **NGINX container** is the only **public entry point**, accessible only via port **443**.

---

## 📂 Example Directory Structure

```shell
$> ls -alR

./
Makefile
secrets/
srcs/

./secrets/
credentials.txt
db_password.txt
db_root_password.txt

./srcs/
docker-compose.yml
.env
requirements/

./srcs/requirements/
bonus/
mariadb/
nginx/
tools/
wordpress/

./srcs/requirements/mariadb/
Dockerfile
.dockerignore
conf/
tools/

./srcs/requirements/nginx/
Dockerfile
.dockerignore
conf/
tools/
