FROM node:bookworm-slim
ENV NODE_ENV=production

WORKDIR /app

COPY ["package.json", "./"]

RUN npm install

COPY . .

# Expose port and add a lightweight healthcheck
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
	CMD curl -f http://localhost:8080/healthz || exit 1

CMD [ "node", "index.js" ]