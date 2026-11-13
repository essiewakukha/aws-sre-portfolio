// PR 8 — minimal API: page, visit counter, health check.
const express = require("express");
const os = require("os");
const { Pool } = require("pg");

const pool = new Pool({ connectionString: process.env.DATABASE_URL });
const app = express();

async function init() {
  await pool.query(
    "CREATE TABLE IF NOT EXISTS visits (id SERIAL PRIMARY KEY, at TIMESTAMPTZ DEFAULT now())"
  );
}

app.get("/app/", (_req, res) => {
  res.send(`<h1>Containerised app</h1><p>Container on ${os.hostname()}</p>
            <p><a href="/app/api/visits">Count a visit</a></p>`);
});

app.get("/app/api/visits", async (_req, res, next) => {
  try {
    await pool.query("INSERT INTO visits DEFAULT VALUES");
    const { rows } = await pool.query("SELECT count(*)::int AS total FROM visits");
    res.json({ host: os.hostname(), visits: rows[0].total });
  } catch (err) {
    next(err);
  }
});

app.get("/app/health", async (_req, res) => {
  try {
    await pool.query("SELECT 1");
    res.json({ status: "ok" });
  } catch {
    res.status(503).json({ status: "db unavailable" });
  }
});

const port = process.env.PORT || 3000;
init()
  .then(() => app.listen(port, () => console.log(`api listening on ${port}`)))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });