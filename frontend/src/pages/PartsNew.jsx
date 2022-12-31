import { useEffect, useState, useRef } from "react"
import { Form, redirect, useActionData, useLoaderData } from "react-router-dom"
import { createSecretParts } from "../util/api"
import PasswordDialog from "../dialogs/PasswordDialog"

export async function partsNewLoader({ params }) {
  if (!session.token) { return redirect("/") }

  return params.id
}

export async function partsNewAction({ request }) {
  const formData = await request.formData()
  const secretId = formData.get("secretId")
  const payload = {
    password: formData.get("password"),
    part: {
      key: formData.get("name"),
      value: formData.get("value")
    }
  }

  const data = await createSecretParts(secretId, session.token, payload)
  if (data.error) {
    return data
  } else {
    return redirect(`/secrets/${secretId}/parts`)
  }
}

export default function PartsNew() {
  const form = useRef()
  const secretId = useLoaderData()
  const part = useActionData()

  const [showDialog, setShowDialog] = useState(false)
  const [password, setPassword] = useState("")
  const [key, setKey] = useState("")
  const [value, setValue] = useState("")

  useEffect(() => {
    if (password) { form.current.requestSubmit() }
  }, [password])

  const handleCreate = (event) => {
    event.preventDefault()

    if(form.current.reportValidity()) {
      setShowDialog(true)
    }
  }

  return (
    <section id="content">
      <h3>New part</h3>
      <div>
        <p>
          Adds a new part that will be encrypted with your password.
        </p>
      </div>
      {part && part.error && <code>{part.error}</code>}
      <Form ref={form} method="post" action={window.location.pathname}>
        <input name="secretId" type="hidden" value={secretId?.toString()}/>
        <input name="password" type="hidden" value={password}/>
        <label>Key</label>
        <input name="name" placeholder="e.g API_KEY" required={true} value={key} onChange={(e) => { setKey(e.target.value) }} />
        <label>Value</label>
        <textarea name="value" placeholder="ZCI6IjYzYTIwN2M5NGNmYWQxMW" required={true} value={value} onChange={(e) => { setValue(e.target.value) }} />
        <button type="button" onClick={handleCreate}>Create</button>
      </Form>

      {showDialog &&
        <PasswordDialog
          isOpen={showDialog}
          setIsOpen={setShowDialog}
          setPassword={setPassword}/>}
    </section>
  )
}
