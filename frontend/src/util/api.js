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

export async function getSecrets(token) {
  return await fetch("https://gateway.localhost/secrets", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": `Bearer ${token}`
    }
  }).then((response) => { return response.json() })
    .then((data) => { return data })
    .catch((err) => { return {error: err}})
}
