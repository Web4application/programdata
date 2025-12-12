import { runAI } from "./ai.js";
import { json, cors } from "./utils.js";

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const path = url.pathname;

    if (request.method === "OPTIONS")
      return new Response("OK", { headers: cors });

    // HOME
    if (path === "/") {
      return new Response(
        `<h1>🔥 Web4AI — Cloudflare AI Backend Online</h1>`,
        { headers: { "Content-Type": "text/html", ...cors } }
      );
    }

    // CHAT API
    if (path === "/chat") {
      const { msg } = await request.json();
      const reply = await runAI(msg, env);
      return json({ reply });
    }

    // STREAMING CHAT
    if (path === "/chat/stream") {
      const { msg } = await request.json();
      const stream = await runAI(msg, env, true);

      return new Response(stream, {
        headers: {
          ...cors,
          "Content-Type": "text/event-stream",
        },
      });
    }

    // SUMMARY
    if (path === "/summarize") {
      const { text } = await request.json();
      const reply = await runAI(`Summarize:\n${text}`, env);
      return json({ summary: reply });
    }

    // DOCUMENT GENERATION
    if (path === "/docgen") {
      const { topic } = await request.json();
      const doc = await runAI(`Create a well-structured document about ${topic}`, env);
      return json({ document: doc });
    }

    // TEXT ANALYSIS
    if (path === "/analyze") {
      const { text } = await request.json();
      const out = await runAI(`Analyze this text deeply:\n${text}`, env);
      return json({ analysis: out });
    }

    // SCRIPT ANALYZER ENDPOINT
    if (path === "/dependencies") {
      const { code } = await request.json();
      const reply = await runAI(
        `Analyze JS dependencies and execution order:\n${code}`,
        env
      );
      return json({ dependencies: reply });
    }

    // 404
    return json({ error: "Not Found" }, 404);
  },
};
