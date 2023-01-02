import Dialog from "../components/Dialog.jsx"
import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { decryptParts } from "../util/api"

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {String} secretId
 * @param {String} returnPath
 * @return {JSX.Element}
 */
export default function DecryptDialog({ isOpen, setIsOpen, secretId, returnPath }) {
  const [data, setData] = useState([])
  const navigate = useNavigate()

  const formSubmit = async (event) => {
    event.preventDefault()

    const payload = {
      password: event.target.password.value
    }

    const responseData = await decryptParts(secretId, payload)
    setData(responseData)

    if (data.error) {
      event.target.password.value = ""

      return
    }

    event.target.password.value = ""
    setIsOpen(false)

    session.decryptedData = responseData

    navigate(returnPath, {state: "decrypting"})
  }

  return (
    <Dialog title="Decrypt parts" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
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
