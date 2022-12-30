import {useEffect, useRef, useState} from "react"
import {Form, redirect, useActionData} from "react-router-dom"
import { createSecret } from "../util/api.js"
import PasswordDialog from "../dialogs/PasswordDialog"

export async function createSecretAction({ request }) {
  const formData = await request.formData()
  const payload = {
    name: formData.get("name"),
    description: formData.get("description"),
    password: formData.get("password")
  }

  const data = await createSecret(session.token, payload)
  if (data.error) {
    return data
  } else {
    return redirect("/secrets")
  }
}

export default function SecretsNew() {
  const form = useRef()
  const [showDialog, setShowDialog] = useState(false)

  const [password, setPassword] = useState("")
  const [name, setName] = useState("")
  const [description, setDescription] = useState("")
  const secret = useActionData()

  const button = useRef(null)

  useEffect(() => {
    if (password) { form.current.requestSubmit() }
  }, [password])

  const handleNext = (event) => {
    event.preventDefault()

    if (form.current.reportValidity()) {
      setShowDialog(true)
    }
  }

  return (
    <section id="content">
      <h3>Create your secret</h3>
      <div>
        <p>
          Use the desired username and secure password combination here, also make sure you know your password because
          you'll be typing it a lot.
        </p>
      </div>
      {secret && secret.error && <code>{secret.error}</code>}
      <Form ref={form} method="post" action="/secrets/new">
        <input name="password" type="hidden" value={password}/>
        <label>Name</label>
        <input name="name" placeholder="e.g Ubuntu host keypair" required={true} value={name} onChange={(e) => { setName(e.target.value) }} />
        <label>Description</label>
        <textarea name="description" placeholder="The one at 127.0.0.1" value={description} onChange={(e) => { setDescription(e.target.value) }} />
        <button type="button" onClick={handleNext}>Create</button>
      </Form>

      {showDialog &&
        <PasswordDialog
          isOpen={showDialog}
          setIsOpen={setShowDialog}
          setPassword={setPassword}/>}
    </section>
  )
}
