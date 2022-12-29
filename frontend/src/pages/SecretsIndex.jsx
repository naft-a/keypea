import { Link, redirect, useLoaderData } from "react-router-dom"
import { getSecrets } from "../util/api"

export async function secretsLoader() {
  if (!session.token) { return redirect("/") }

  const fetchedSecrets = await getSecrets(session.token)
  if (fetchedSecrets) {
    sessionStorage.setItem("secrets", JSON.stringify(fetchedSecrets))

    return fetchedSecrets
  } else {
    return []
  }
}

export default function SecretsIndex() {
  const secrets = useLoaderData()

  const renderSecrets = () => {
    if (secrets instanceof Object && secrets.error) {
      return (
        <code>{secrets.error}</code>
      )
    }

    if (secrets.length === 0) {
      return(
        <>
          <h4>Nothing found here</h4>
          <p>You don't seem to have any secrets.</p>
        </>
      )
    }

    return (
      <ol>
        {secrets && secrets.map(secret => (
          <li key={secret.id}>
            <pre>
              <Link to={secret.id}>{secret.name}</Link>
              <p>{secret.description}</p>
            </pre>
          </li>
        ))}
      </ol>
    )
  }

  return(
    <section id="secrets">
      {renderSecrets(secrets)}
    </section>
  )
}
