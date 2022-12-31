import { Form, redirect, useActionData } from "react-router-dom"
import { useEffect, useState } from "react"
import { createUser } from "../util/api"

export async function signupAction({ request }) {
  const formData = await request.formData()
  const payload = {
    username: formData.get("username"),
    password: formData.get("password")
  }

  const data = await createUser(payload)
  if (data.error) {
    return data
  } else {
    session.token = data.access_token
    session.dispatchAuthenticated()

    return redirect("/secrets")
  }
}

export default function Signup() {
  const [matches, setMatches] = useState(true)
  const [password, setPassword] = useState("")
  const [confirmationPassword, setConfirmationPassword] = useState("")
  const data = useActionData()

  useEffect(() => { setMatches(password === confirmationPassword) })

  return (
    <div id="signup">
      <h3>Sign up!</h3>
      <div>
        <p>
          Use a secure username and password combination here, also make sure you know your password because
          if you lose your password all data will be lost forever.
        </p>
      </div>
      {data && data.error && <code>{data.error}</code>}
      <Form method="post" action="/signup">
        <label>Username</label>
        <input name="username" placeholder="Your username.." />
        <label>Password</label>
        <input className={!matches ? "mismatch" : ""} name="password" type="password" onChange={ e => setPassword(e.target.value) } />
        <label>Confirm Password</label>
        <input className={!matches ? "mismatch" : ""} name="password-confirm" type="password" onInput={ e => setConfirmationPassword(e.target.value ) } />
        <input name="submit" type="submit" value="Create" disabled={!matches || password === ""} />
      </Form>
    </div>
  )
}
