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
 * @return {Object}
 */
export async function logoutUser() {
  return await makeRequest({
    path: "/sessions/logout",
    method: "DELETE",
    token: session.token
  })
}

/**
 * @return {Object}
 */
export async function getSecrets() {
  return await makeRequest({
    path: "/secrets",
    method: "GET",
    token: session.token,
  })
}

/**
 * @param {String} id
 * @return {Object}
 */
export async function getSecret(id) {
  const secrets = await getSecrets()
  if (secrets?.error) { return secrets }

  const secret =  secrets.find((s) => { return s.id === id })
  // debugger

  return secret
}

/**
 * @param {Object} payload
 * @return {Object}
 */
export async function createSecret(payload) {
  return await makeRequest({
    path: "/secrets",
    method: "POST",
    token: session.token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {String} id
 * @param {Object} payload
 * @return {Object}
 */
export async function updateSecret(id,payload) {
  return await makeRequest({
    path: `/secrets/${id}`,
    method: "PATCH",
    token: session.token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {Object.<string>}
 * @return {Object}
 */
export async function deleteSecret({ secretId }) {
  return await makeRequest({
    path: `/secrets/${secretId}`,
    method: "DELETE",
    token: session.token
  })
}

/**
 * @param {String} id
 * @param {Object} payload
 * @return {Object}
 */
export async function createSecretParts(id, payload) {
  return await makeRequest({
    path: `/secrets/${id}/parts`,
    method: "POST",
    token: session.token,
    body: JSON.stringify(payload)
  })
}

/**
 * @param {Object.<string>}
 * @return {Object}
 */
export async function deleteSecretParts({ secretId, partId }) {
  return await makeRequest({
    path: `/secrets/${secretId}/parts/${partId}`,
    method: "DELETE",
    token: session.token
  })
}

/**
 * @param {String} id
 * @param {Object} payload
 * @return {Object}
 */
export async function decryptParts(id, payload) {
  return await makeRequest({
    path: `/secrets/${id}/parts/decrypt`,
    method: "POST",
    token: session.token,
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
