export async function handleSummarize(req, env) {
  const { text } = await req.json();

  const body = {
    model: "gpt-5.1-mini",
    messages: [
      { role: "system", content: "Summarize the user's input clearly." },
      { role: "user", content: text },
    ],
  };

  const res = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  return res;
}
