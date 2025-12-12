export async function handleChat(req, env) {
  const { prompt } = await req.json();

  const res = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "gpt-5.1-mini",
      messages: [{ role: "user", content: prompt }],
    }),
  });

  return new Response(await res.text(), {
    headers: { "Content-Type": "application/json" },
  });
}
