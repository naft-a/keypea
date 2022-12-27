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
    requireToken: true,
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": `Bearer ${token}`
    }
  })
}

// private

async function makeRequest({...params}) {
  const { path, method, headers, body, requireToken } = params

  return await fetch(`https://gateway.localhost${path}`, {
    method: method,
    headers: headers,
    body: body
  }).then((response) => {
      if (!requireToken) {
        return response.json()
      }

      if (response.status === 401) {
        window.authenticated = false

        return null
      } else {
        window.authenticated = true

        return response.json()
      }
    })
    .then((data) => { return data })
    .catch((err) => { return {error: err}})
}
