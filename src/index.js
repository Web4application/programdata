export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;

    // CORS (Universal)
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
      "Access-Control-Allow-Headers": "*",
    };

    if (request.method === "OPTIONS") {
      return new Response("OK", { headers: corsHeaders });
    }

    // Home Page (HTML)
    if (path === "/") {
      return new Response(`
        <html>
          <head>
            <title>Web4-AI API</title>
            <style>
              body { font-family: system-ui; padding: 40px; }
              h1 { color: #1a1a1a; }
              code { background: #f1f1f1; padding: 4px; }
            </style>
          </head>
          <body>
            <h1>🔥 Web4-AI Cloudflare Worker</h1>
            <p>Welcome to your AI API gateway. Try:</p>

            <ul>
              <li><code>/api</code></li>
              <li><code>/analyze?text=Hello</code></li>
              <li><code>/ai</code> (POST JSON)</li>
            </ul>

            <p>Powered by: <strong>${env.APP_NAME}</strong></p>
          </body>
        </html>
      `, { headers: { "Content-Type": "text/html", ...corsHeaders }});
    }

    // Basic API endpoint
    if (path === "/api") {
      return Response.json({
        status: "ok",
        project: env.APP_NAME,
        message: "Web4-AI Worker is running perfectly",
      }, { headers: corsHeaders });
    }

    // Text analysis endpoint
    if (path === "/analyze") {
      const text = url.searchParams.get("text") || "";
      return Response.json({
        text,
        length: text.length,
        uppercase: text.toUpperCase(),
      }, { headers: corsHeaders });
    }

    // AI endpoint (placeholder)
    if (path === "/ai") {
      const body = await request.json().catch(() => ({}));
      return Response.json({
        input: body,
        reply: "AI module connected successfully",
        status: "ready",
      }, { headers: corsHeaders });
    }

    // 404
    return new Response("Not Found", {
      status: 404,
      headers: corsHeaders,
    });
  }
};
