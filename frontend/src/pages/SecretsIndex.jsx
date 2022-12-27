import { Link, redirect, useLoaderData } from "react-router-dom"
import { getSecrets } from "../util/api"

export async function SecretsLoader({ request, authContext }) {
  const { token } = authContext

  const fetchedSecrets = await getSecrets(token)
  if (fetchedSecrets) {
    return fetchedSecrets
  } else {
    return []
  }
}

export default function SecretsIndex() {
  const secrets = useLoaderData()

  return(
    <>
      <h3>Secrets</h3>
      {secrets?.error && <code>{secrets.error}</code>}
      <ul>
        {secrets.map(secret => (
          <li key={secret.id}>
            <Link to={secret.id}>{secret.name}</Link>
            <p>{secret.description}</p>
          </li>
        ))}
      </ul>
    </>
  )
}
