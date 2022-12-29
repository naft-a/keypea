import { useLoaderData, useParams } from 'react-router-dom'

export async function secretLoader({ params }) {
  const { id } = params

  const fetchedSecrets = sessionStorage.getItem("secrets")
  if (!fetchedSecrets) { return null }

  const secrets = JSON.parse(fetchedSecrets)
  if (!secrets) { return null }

  const secret = secrets.find((s) => { return s.id === id })
  if (!secret) { return null }

  return secret
}

export default function SecretsShow() {
  const { id } = useParams()
  const secret = useLoaderData()

  const formattedSecret = () => {
    const { id, user_id, ...rest } = secret

    rest["created_at"] = new Date(rest["created_at"]).toString()
    rest["updated_at"] = new Date(rest["updated_at"]).toString()

    return rest
  }

  return(
    <>
      <br></br>
      <pre>
        {JSON.stringify(formattedSecret(), undefined, 2)}
      </pre>
    </>
  )
}
