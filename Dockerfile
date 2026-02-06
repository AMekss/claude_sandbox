FROM node:25

RUN npm install -g @anthropic-ai/claude-code

WORKDIR "code"
