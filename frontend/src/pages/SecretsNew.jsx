import { useRef, useState } from "react"
import { Form, redirect, useActionData } from "react-router-dom"
import { createSecret } from "../util/api"

export async function secretsNewLoader() {
  if (!session.token) { return redirect("/") }

  return null
}

export async function secretsNewAction({ request }) {
  const formData = await request.formData()
  const payload = {
    name: formData.get("name"),
    description: formData.get("description")
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

  const [name, setName] = useState("")
  const [description, setDescription] = useState("")
  const secret = useActionData()

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
      <Form ref={form} method="post" action={window.location.pathname}>
        <label>Name</label>
        <input name="name" placeholder="e.g Ubuntu host keypair" required={true} value={name} onChange={(e) => { setName(e.target.value) }} />
        <label>Description</label>
        <textarea name="description" placeholder="The one at 127.0.0.1" value={description} onChange={(e) => { setDescription(e.target.value) }} />
        <input type="submit" value="Create" />
      </Form>
    </section>
  )
}
