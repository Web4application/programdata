import { handleChat } from "./modules/chat.js";
import { handleEmbed } from "./modules/embed.js";
import { handleSummarize } from "./modules/summarize.js";
import { handleVision } from "./modules/vision.js";
import { getKV, setKV } from "./modules/kv.js";

export default {
  async fetch(req, env, ctx) {
    const url = new URL(req.url);
    const path = url.pathname;

    // CORS
    if (req.method === "OPTIONS") {
      return new Response("OK", {
        headers: cors(),
      });
    }

    // -------- SYSTEM ROUTES --------
    if (path === "/api/system/ping") {
      return Response.json({ pong: true, time: Date.now() }, { headers: cors() });
    }

    if (path === "/api/system/info") {
      return Response.json({
        name: "Web4-AI Worker",
        author: "Seriki Yakub (Kubu Lee)",
        env: env.ENV,
        version: "v1.0",
      }, { headers: cors() });
    }

    // -------- AI ROUTES --------
    if (path === "/api/ai/chat") return handleChat(req, env);
    if (path === "/api/ai/embed") return handleEmbed(req, env);
    if (path === "/api/ai/summarize") return handleSummarize(req, env);
    if (path === "/api/ai/vision") return handleVision(req, env);

    // -------- KV STORAGE --------
    if (path === "/api/kv/get") return getKV(req, env);
    if (path === "/api/kv/set") return setKV(req, env);

    return new Response("Route Not Found", { status: 404, headers: cors() });
  }
};

// CORS
function cors() {
  return {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "*",
    "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",
  };
}
