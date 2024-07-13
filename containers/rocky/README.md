```bash
podman build \
    --tag rocky9dev:latest \
    .
```

```bash
podman run \
    --network host \
    rocky9dev:latest
```
