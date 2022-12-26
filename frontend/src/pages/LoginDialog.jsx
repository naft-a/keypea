import { Form, redirect, useActionData } from "react-router-dom"
import Dialog from "../components/Dialog"
import { authenticateUser } from "../util/api"

export async function loginAction({ request }) {
  const formData = await request.formData()
  const payload = {
    username: formData.get("username"),
    password: formData.get("password")
  }

  const data = await authenticateUser(payload)
  if (data.error ) {
    return data
  } else {
    return redirect("/secrets")
  }
}

export default function LoginDialog() {
  const data = useActionData()

  return (
    <Dialog identifier="loginDialog" name="Log in">
      {data && data.error && <code>{data.error}</code>}
      <Form method="post" action="/login">
        <label>Username</label>
        <input name="username" required={true} />
        <label>Password</label>
        <input name="password" type="password" required={true}/>
        <input name="submit" type="submit" value="Login" required={true} />
      </Form>
    </Dialog>
  )
}
