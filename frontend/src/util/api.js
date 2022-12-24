export async function createUser(payload) {
  return await fetch("https://gateway.localhost/sessions", {
    method: "POST",
    body: JSON.stringify(payload),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  }).then(response => response.json())
    .then((data) => { return data })
    .catch((err) => { return {error: err}})
}
