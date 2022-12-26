import { Link, redirect, useLoaderData } from "react-router-dom"
import { getSecrets } from "../util/api"

export async function secretsLoader() {
  // todo: get token from context
  return getSecrets("eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjYzYTdhOTllNGNmYWQxNDNmMTcxOGRhOCIsImV4cCI6MTY3MjAxODcxOH0.KK2a4CK-yIe2agKGkDmz0ec78KdobcxzXa6jU05rycw")
}

export default function SecretsIndex() {
  const secrets = useLoaderData()

  return(
    <>
      <h3>Secrets</h3>
      {secrets && secrets.error && <code>{secrets.error}</code>}
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
