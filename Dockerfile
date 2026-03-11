FROM debian:trixie-slim


RUN apt-get update -qq && apt-get install -y \
        build-essential \
        docker-cli \
        curl \
        jq \
        git

ENV PATH="/root/.local/bin:$PATH" \
    CLAUDE_CONFIG_DIR="/root/.claude" \
    COLORTERM=truecolor

RUN curl -fsSL https://claude.ai/install.sh | bash
