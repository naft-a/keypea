import { Link, redirect, useLoaderData } from "react-router-dom"
import { getSecrets } from "../util/api"

export async function secretsLoader() {
  // todo: get token from context
  const secrets = await getSecrets("eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjYzYTIwN2M5NGNmYWQxMWIxYzJlMGU0NiIsImV4cCI6MTY3MjE5MjMxMH0.QjBXKRiVJRBqZ8N-vzuYS45_dPXLXgcKCHJ67MZ1kUU")
  return secrets
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
