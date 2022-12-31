/**
 * @param {Object} payload
 * @return {Object}
 */
export async function createUser(payload) {
  return await makeRequest({
    path: "/sessions",
    method: "POST",
    body: JSON.stringify(payload)
  })
}

/**
 * @param {Object} payload
 * @return {Object}
 */
export async function authenticateUser(payload) {
  return await makeRequest({
    path: "/sessions/login",
    method: "POST",
    body: JSON.stringify(payload)
  })
}

/**
 * @param {String} token
 * @return {Object}
 */
export async function logoutUser(token) {
  return await makeRequest({
    path: "/sessions/logout",
    method: "DELETE",
    token: token
  })
}

/**
 * @param {String} token
 * @return {Object}
 */
export async function getSecrets(token) {
  return await makeRequest({
    path: "/secrets",
    method: "GET",
    token: token,
  })
}

/**
 * @param {String} id
 * @param {String} token
 * @return {Object}
 */
export async function getSecret(id, token) {
  const secrets = await getSecrets(token)
  if (secrets?.error) { return secrets }

  return secrets.find((s) => { return s.id === id })
}

/**
 * @param {String} token
 * @param {Object} payload
 * @return {Object}
 */
export async function createSecret(token, payload) {
  return await makeRequest({
    path: "/secrets",
    method: "POST",
    token: token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {String} id
 * @param {String} token
 * @param {Object} payload
 * @return {Object}
 */
export async function updateSecret(id, token,payload) {
  return await makeRequest({
    path: `/secrets/${id}`,
    method: "PATCH",
    token: token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {String} id
 * @param {String} token
 * @param {Object} payload
 * @return {Object}
 */
export async function createSecretParts(id, token, payload) {
  return await makeRequest({
    path: `/secrets/${id}/parts`,
    method: "POST",
    token: token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {String} id
 * @param {String} token
 * @param {Object} payload
 * @return {Object}
 */
export async function decryptParts(id, token, payload) {
  return await makeRequest({
    path: `/secrets/${id}/parts/decrypt`,
    method: "POST",
    token: token,
    body: JSON.stringify(payload)
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
          session.token = null
          session.dispatchUnauthenticated()

          reject("Unauthenticated user")
        } else {
          resolve(response.json())
        }
      })
    })
    .then((data) => { return data })
    .catch((err) => { return {error: err.toString()} })
}
