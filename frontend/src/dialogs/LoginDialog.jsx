import Dialog from "../components/Dialog.jsx"
import {useEffect, useState} from "react"
import { useNavigate } from "react-router-dom"
import { authenticateUser } from "../util/api"

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {String} returnPath
 * @return {JSX.Element}
 */
export default function LoginDialog({ isOpen, setIsOpen, returnPath }) {
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

    session.token = data.access_token
    session.dispatchAuthenticated()

    event.target.username.value = ""
    event.target.password.value = ""

    setIsOpen(false)

    navigate(returnPath)
  }

  return (
    <Dialog title="Log in" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
      <div className="error">
        {data?.error && <code>{data.error}</code>}
      </div>
      <form method="post" onSubmit={formSubmit}>
        <label>Username</label>
        <input name="username" required={true} />
        <label>Password</label>
        <input name="password" type="password" required={true}/>
        <input name="submit" type="submit" value="Login" />
      </form>
    </Dialog>
  )
}
