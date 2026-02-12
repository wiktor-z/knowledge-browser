FROM node:20-alpine

WORKDIR /app

COPY services/ui/package.json /app/package.json
COPY services/ui/src /app/src

EXPOSE 3000

CMD ["npm", "run", "start"]
