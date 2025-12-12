export async function runAI(prompt, env, stream = false) {
  const apiKey = env.OPENAI_API_KEY;

  const body = {
    model: "gpt-4o-mini",
    messages: [{ role: "user", content: prompt }],
    stream,
  };

  const res = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  if (stream) {
    return res.body; // Streaming response
  }

  const json = await res.json();
  return json.choices[0].message.content;
}
