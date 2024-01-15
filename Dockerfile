FROM node:20-alpine3.19 as builder
WORKDIR "/app"
RUN --mount=type=cache,target=/root/.npm \
    npm install -g pnpm
COPY package.json .
RUN apk add --no-cache git && npm install
COPY . .
RUN pnpm build

FROM nginx
EXPOSE 80
COPY --from=builder /app/out /usr/share/nginx/html
