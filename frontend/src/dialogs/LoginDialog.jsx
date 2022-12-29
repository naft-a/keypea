import Dialog from "../components/Dialog.jsx"
import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { authenticateUser } from "../util/api"

export default function LoginDialog() {
  const [data, setData] = useState({})
  const navigate = useNavigate()

  const formSubmit = async (event) => {
    event.preventDefault()

    const payload = {
      username: event.target.username.value,
      password: event.target.password.value
    }

    const data = await authenticateUser(payload)
    setData(data)

    if (data.error) {
      event.target.password.value = ""

      return
    }

    window.token = data.access_token

    event.target.username.value = ""
    event.target.password.value = ""
    event.target.parentElement.close()

    navigate("/secrets")
  }

  return (
    <Dialog identifier="loginDialog" name="Log in">
      <div className="error">
        {data?.error && <code>{data.error}</code>}
      </div>
      <form method="post" onSubmit={formSubmit}>
        <label>Username</label>
        <input name="username" required={true} />
        <label>Password</label>
        <input name="password" type="password" required={true}/>
        <input name="submit" type="submit" value="Login" required={true} />
      </form>
    </Dialog>
  )
}
