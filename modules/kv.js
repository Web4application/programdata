export async function getKV(req, env) {
  const key = new URL(req.url).searchParams.get("key");
  const value = await env.WEB4_KV.get(key);
  return Response.json({ key, value });
}

export async function setKV(req, env) {
  const { key, value } = await req.json();
  await env.WEB4_KV.put(key, value);
  return Response.json({ ok: true, key, value });
}
