import { useLoaderData } from 'react-router-dom'
import { getSecret } from "../util/api"

export async function secretLoader({ params }) {
  if (!session.token) { return {error: "Not authenticated"} }

  const { id } = params

  const fetchedSecret = await getSecret(id)
  if (fetchedSecret) {
    return fetchedSecret
  } else {
    return {error: "The secret could not be fetched."}
  }
}

export default function SecretsShow() {
  const secret = useLoaderData()

  const formatSecret = (secret) => {
    const { id, user_id, ...rest } = secret

    return rest
  }

  const render = (secret) => {
    if (secret instanceof Object && secret.error) {
      return (
        <code>{secret.error}</code>
      )
    } else {
      return (
        <pre>
          {JSON.stringify(formatSecret(secret), undefined, 2)}
        </pre>
      )
    }
  }

  return(
    <section id="content">
      {render(secret)}
    </section>
  )
}
