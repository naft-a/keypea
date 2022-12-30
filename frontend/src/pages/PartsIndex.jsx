import {redirect, useLoaderData, useLocation} from "react-router-dom"
import { useEffect, useState } from "react"
import {getSecret} from "../util/api.js";

export async function partsLoader({ params }) {
  if (!session.token) { return redirect("/") }

  const { id } = params

  const fetchedSecret = await getSecret(id, session.token)
  if (fetchedSecret) {
    return fetchedSecret.parts
  } else {
    return {error: "The secret could not be fetched."}
  }
}

export default function PartsIndex() {
  const location = useLocation()
  const parts = useLoaderData()
  const [data, setData] = useState(parts)

  useEffect(() => {
    if (!location.state) { return }

    setData(location.state.parts)
  }, [location.state])

  const formatParts = (parts) => {
    return parts.map((part) => {
      const { id, ...rest } = part

      return rest
    })
  }

  return (
    <>
      <br></br>
      <pre>
        {JSON.stringify(formatParts(data), undefined, 2)}
      </pre>
    </>
  )
}
