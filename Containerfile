FROM louislam/uptime-kuma:latest

WORKDIR /app

RUN sed -i 's/PRAGMA synchronous = FULL/PRAGMA synchronous = NORMAL/g;s/min: 1,/min: 0,/g;s/max: 1,/max: 10, reapIntervalMillis: 1000, createRetryIntervalMillis: 200,/g;s/idleTimeoutMillis: 120 \* 1000,/idleTimeoutMillis: 30 \* 1000,/g' /app/server/database.js

EXPOSE 3001

VOLUME ["/app/data"]

HEALTHCHECK --interval=60s --timeout=30s --start-period=180s --retries=5 CMD node extra/healthcheck.js

ENTRYPOINT ["/usr/bin/dumb-init", "--", "extra/entrypoint.sh"]

CMD ["node", "server/server.js"]
