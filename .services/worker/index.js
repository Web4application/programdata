export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;

    // --- ROUTER ---
    if (path === "/" && request.method === "GET") {
      return Response.json({
        status: "ok",
        message: "Web4-AI Worker Online",
        version: "v1",
        author: "Seriki Yakub (Kubu Lee)"
      });
    }

    if (path.startsWith("/api/ai/query")) {
      return handleAI(request, env);
    }

    if (path.startsWith("/api/ai/embed")) {
      return handleEmbedding(request, env);
    }

    if (path.startsWith("/api/echo")) {
      return Response.json(await request.json());
    }

    if (path.startsWith("/static")) {
      return env.ASSETS.fetch(request);
    }

    return new Response("Route not found", { status: 404 });
  }
};

// ========== AI HANDLER ==========
async function handleAI(request, env) {
  const { prompt } = await request.json();

  const response = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: "gpt-5.1-mini",
      messages: [{ role: "user", content: prompt }]
    })
  });

  return response;
}

// ========== EMBEDDING HANDLER ==========
async function handleEmbedding(request, env) {
  const { input } = await request.json();

  const embedding = await fetch("https://api.openai.com/v1/embeddings", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: "text-embedding-3-large",
      input
    })
  });

  return embedding;
}
