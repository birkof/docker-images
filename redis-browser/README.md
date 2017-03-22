# Minimal Redis Browser Docker Image

A [Docker](https://www.docker.com/) container for [Redis Browser](https://github.com/humante/redis-browser).

## Example usage
```bash
docker run --name redis-container -d redis && \
docker run -d --link redis-container:redis -p 4567:4567 birkof/redis-browser --url redis://redis-container:6379
```

Redis Browser will be running on port: `4567`

### Via Docker compose
`docker-compose.yml`
```yml
redis-container:
  image: redis
redis-browser:
  image: birkof/redis-browser
  command: --url redis://redis-container:6379
  ports:
    - 4567:4567
```
Followed by: `docker-compose up`

### Available CLI Options
```
# redis-browser --help
Usage: redis-browser [options]
    -C, --config PATH                Path to YAML config file
    -U, --url URL                    Connection URL. Defaults to redis://127.0.0.1:6379/0
    -B, --bind ADDRESS               Server hostname or IP address to listen on
    -P, --port PORT                  Port number to listen on
```

> For docker not running on localhost/127.0.0.1 you will need to set the bind address accordingly. For non-production environments `0.0.0.0` can be used to allow all ip addresses `--bind 0.0.0.0`.
