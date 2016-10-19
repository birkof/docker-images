# Redis Browser Docker Image

A [Docker](https://www.docker.com/) container for [Redis Commander](https://github.com/humante/redis-browser).

## Example usage
```bash
docker run --name redis-container -d redis && \
docker run -d --link redis-container:redis -p 4567:4567 birkof/redis-browser --url redis://redis-container:6379
```

Redis Commander will be running on port: `8081`

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