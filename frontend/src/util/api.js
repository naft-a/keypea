export async function createUser(payload) {
  return await makeRequest({
    path: "/sessions",
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
    path: "/sessions/login",
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
    path: "/secrets",
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
  const { path, method, headers, body } = params

  return await fetch(`https://gateway.localhost${path}`, {
    method: method,
    headers: headers,
    body: body
  }).then((response) => { return response.json() })
    .then((data) => { return data })
    .catch((err) => { return {error: err}})
}
