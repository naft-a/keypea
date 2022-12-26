export async function createUser(payload) {
  return await makeRequest({
    url: "https://gateway.localhost/sessions",
    method: "POST",
    body: JSON.stringify(payload),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  })
}

export async function authenticateUser(payload) {
  return await makeRequest({
    url: "https://gateway.localhost/sessions/login",
    method: "POST",
    body: JSON.stringify(payload),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  })
}

export async function getSecrets(token) {
  return await makeRequest({
    url: "https://gateway.localhost/secrets",
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": `Bearer ${token}`
    }
  })
}

// private

async function makeRequest({...params}) {
  const { url, method, headers, body } = params

  return await fetch(url, {
    method: method,
    headers: headers,
    body: body
  }).then((response) => { return response.json() })
    .then((data) => { return data })
    .catch((err) => { return {error: err}})
}
