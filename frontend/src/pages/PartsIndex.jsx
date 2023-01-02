import { useEffect, useState } from "react"
import { redirect, useLoaderData, useLocation, useParams } from "react-router-dom"
import { deleteSecretParts, getSecret } from "../util/api"
import DestroyDialog from "../dialogs/DestroyDialog.jsx"

export async function partsLoader({ params }) {
  if (!session.token) { return redirect("/") }

  const { id } = params

  const fetchedSecret = await getSecret(id)
  if (fetchedSecret) {
    return fetchedSecret.parts
  } else {
    return {error: "The secret could not be fetched."}
  }
}

export default function PartsIndex() {
  const location = useLocation()
  const params = useParams()
  const loadedParts = useLoaderData()

  const [data, setData] = useState(loadedParts)
  const [partId, setPartId] = useState(null)
  const [showDestroyDialog, setShowDestroyDialog] = useState(false)

  // sets parts data after destroying
  useEffect(() => {
    if (location.state === "destroying") {
      setData(loadedParts)
    }
  }, [loadedParts])

  // sets parts data after decryption
  useEffect(() => {
    if (location.state === "decrypting") {
      setData(session.decryptedData || loadedParts)
      session.decryptedData = null
    }
  }, [location])

  const formatPart = (part) => {
    const { id, ...rest } = part

    return rest
  }

  const setButtonProps = (event) => {
    setPartId(event.target.dataset.partId)
    setShowDestroyDialog(true)
  }


  const render = (parts) => {
    if (parts instanceof Object && parts.error) {
      return (
        <>
          <code>{parts.error}</code>
          {loadedParts && loadedParts.map((part) => (
            <div id="parts" key={part.id}>
            <pre>
              {JSON.stringify(formatPart(part), undefined, 2)}
            </pre>
              <a href="#" className="destroy" onClick={setButtonProps} data-part-id={part.id}>[ Destroy ]</a>
            </div>
          ))}
        </>
      )
    }

    if (parts.length === 0) {
      return (
        <>
          <h4>Nothing found here</h4>
          <p>You don't seem to have any parts in this secret.</p>
        </>
      )
    }

    if (parts) {
      return (
        <>
          {parts && parts.map((part) => (
            <div id="parts" key={part.id}>
              <pre>
                {JSON.stringify(formatPart(part), undefined, 2)}
              </pre>
              <a href="#" className="destroy" onClick={setButtonProps} data-part-id={part.id}>[ Destroy ]</a>
            </div>
          ))}
        </>
      )
    }
  }

  return (
    <>
      <section id="content">
        {render(data)}
      </section>

      {(showDestroyDialog) &&
        <DestroyDialog
          isOpen={showDestroyDialog}
          setIsOpen={setShowDestroyDialog}
          apiMethod={deleteSecretParts}
          params={{secretId: params.id, partId: partId}}
          returnPath={`/secrets/${params.id}/parts`}/>}
    </>
  )
}
