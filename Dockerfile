FROM node:22-slim AS builder

WORKDIR /app

COPY pnpm-lock.yaml ./
COPY pnpm-workspace.yaml ./
COPY packages/crypto/package.json packages/crypto/package.json
COPY packages/lib/package.json packages/lib/package.json
COPY packages/app-client/package.json packages/app-client/package.json
COPY packages/app-server/package.json packages/app-server/package.json

RUN npm install -g pnpm  --ignore-scripts && \
    pnpm config set registry https://registry.npmjs.org && \
    pnpm install --frozen-lockfile --ignore-scripts

COPY . .

RUN pnpm --filter @enclosed/crypto run build && \
    pnpm --filter @enclosed/lib run build && \
    pnpm --filter @enclosed/app-client run build && \
    pnpm --filter @enclosed/app-server run build:node

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app/packages/app-client/dist ./public
COPY --from=builder /app/packages/app-server/dist-node/index.cjs ./index.cjs

RUN mkdir -p /app/.data

ENV TZ=Asia/Shanghai
EXPOSE 8787

CMD ["node", "index.cjs"]
