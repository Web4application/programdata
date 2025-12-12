export async function handleVision(req, env) {
  const { image, prompt } = await req.json();

  const body = {
    model: "gpt-5.1-mini",
    messages: [
      {
        role: "user",
        content: [
          { type: "input_image", image_url: image },
          { type: "text", text: prompt }
        ],
      }
    ]
  };

  return fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });
}
