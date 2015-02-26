# Instructions

## Build

```
# docker build -t redbook-platform:<tag> .
```

## Run

Requirements:
- Access to Mysql server
- Redbook application code mouted as a volume inside container

```
# docker run -d -v /path/to/redbook:/app --link <db_container>:mysql redbook-platform:<tag>
# docker run -d -v ~/redbook/config:/app/config -v /etc/localtime:/etc/localtime:ro -v /etc/timezone:/etc/timezone:ro --link mysql5.6:mysql redbook-development:2b5bbef
```

Optional:
- add ```-p 80``` to expose port 80 (web server) to docker host
