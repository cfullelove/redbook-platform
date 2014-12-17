# Instructions

## Build

```
# docker build -t redbook-platform:<tag> .
```

## Run

Requirements:
- Access to Mysql server

```
# docker run -d -v /path/to/redbook:/app --link <db_container>:mysql redbook-platform:<tag>
```

Optional:
- add ```-p 80``` to expose port 80 (web server) to docker host
