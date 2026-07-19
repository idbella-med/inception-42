# Developer documentation

- Build images and start services:

```bash
cd srcs
docker-compose up --build -d
```

- Place your secrets in `./secrets/db_root_password.txt` and `./secrets/db_password.txt` before starting.
- Volumes are configured to store data under `/home/mohamed/data` on the host.
