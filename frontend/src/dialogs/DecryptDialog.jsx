import Dialog from "../components/Dialog.jsx"
import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { decryptParts } from "../util/api"

export default function DecryptDialog({ secretId, returnPath }) {
  const [data, setData] = useState([])
  const navigate = useNavigate()

  const formSubmit = async (event) => {
    event.preventDefault()

    const payload = {
      password: event.target.password.value
    }

    const responseData = await decryptParts(secretId, session.token, payload)
    setData(responseData)

    if (data.error) {
      event.target.password.value = ""

      return
    }

    event.target.password.value = ""
    event.target.parentElement.close()

    navigate(returnPath, {state: {parts: responseData}})
  }

  return (
    <Dialog identifier="decryptDialog" name="Decrypt parts">
      <div className="error">
        {data?.error && <code>{data.error}</code>}
      </div>
      <form method="post" onSubmit={formSubmit}>
        <label>Password</label>
        <input name="password" type="password" required={true}/>
        <input name="submit" type="submit" value="Decrypts" />
      </form>
    </Dialog>
  )
}
