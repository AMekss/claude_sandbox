# Claude code sandbox

### Security notes

The sandbox can `exec` commands into **any running container on the host** via the Docker socket proxy. This is intentional — it allows Claude to run tests, migrations, etc. in your dev containers. Only run this setup on a machine where all containers are trusted development workloads, not production or sensitive services.

### Setup

Before starting, find the GID of the Docker socket on your host and update the `user` field in `compose.yml` for the `socket-proxy` service (`65534:<docker-gid>`):

```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock alpine stat -c '%g' /var/run/docker.sock
```

### Build

```
docker compose build
```

### Run

Launch a session from any project directory using the `cs` function from [dotfiles](https://github.com/AMekss/dotfiles/blob/master/bash/functions/claude_sandbox):

```
cd ~/code/your-project
cs
```

This mounts the current directory as `/your-project` inside the sandbox and starts Claude there. The container is removed automatically when you exit.
