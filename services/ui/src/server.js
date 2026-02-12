import { createServer } from "node:http";
import { readFileSync } from "node:fs";
import { join } from "node:path";

const port = Number.parseInt(process.env.UI_PORT ?? "3000", 10);
const apiBaseUrl = process.env.API_BASE_URL ?? "http://localhost:8000";
const indexFile = readFileSync(join(process.cwd(), "src", "index.html"), "utf-8");

const server = createServer((request, response) => {
  if (request.url === "/healthz") {
    response.writeHead(200, { "Content-Type": "application/json" });
    response.end(JSON.stringify({ status: "ok" }));
    return;
  }

  response.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
  response.end(indexFile.replace("__API_BASE_URL__", apiBaseUrl));
});

server.listen(port, "0.0.0.0", () => {
  console.log(`kb-ui listening on port ${port}`);
});
