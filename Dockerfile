FROM node:18-alpine AS builder

WORKDIR /app

COPY . /app

RUN npm ci && \
    npm run build


FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/build /app/build
COPY --from=builder /app/package.json /app/
COPY --from=builder /app/package-lock.json /app/

RUN npm ci --omit dev
CMD ["node", "./build"]