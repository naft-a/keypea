export async function createUser(payload) {
  return await makeRequest({
    path: "/sessions",
    method: "POST",
    body: JSON.stringify(payload)
  })
}

export async function authenticateUser(payload) {
  return await makeRequest({
    path: "/sessions/login",
    method: "POST",
    body: JSON.stringify(payload)
  })
}

export async function getSecrets(token) {
  return await makeRequest({
    path: "/secrets",
    method: "GET",
    token: token,
  })
}

// private

async function makeRequest({...params}) {
  const { path, method, body, token } = params
  let defaultHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  }

  return await fetch(`https://gateway.localhost${path}`, {
    method: method,
    headers: {...(token) && {"Authorization": `Bearer ${token}`}, ...defaultHeaders},
    body: body
  }).then((response) => {
      return new Promise((resolve, reject) => {
        if (response.status === 401) {
          window.authenticated = false

          reject("Unauthenticated user")
        } else {
          window.authenticated = true

          resolve(response.json())
        }
      })
    })
    .then((data) => { return data })
    .catch((err) => { return {error: err.toString()} })
}
