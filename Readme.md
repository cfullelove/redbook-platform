# Instructions

## Build

```
	# docker build -t redbook-platform:<tag> .
```

## Run

```
	# docker run -d -v/path/to/redbook:/app --link <db_container>:mysql redbook-platform:<tag>
```