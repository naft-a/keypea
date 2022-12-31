import Dialog from "../components/Dialog.jsx"
import { useEffect, useState } from "react"
import { useNavigate } from "react-router-dom"
import {getSecret, getSecrets, updateSecret} from "../util/api"

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {String} secretId
 * @return {JSX.Element}
 */
export default function EditSecretDialog({ isOpen, setIsOpen, secretId }) {
  const navigate = useNavigate()

  const [response, setResponse] = useState(null)
  const [name, setName] = useState("")
  const [description, setDescription] = useState("")

  useEffect(() => {
    const fetchData = async (id, token) => {
      const secret = await getSecret(id, token)
      if (!secret) { return }

      setName(secret.name)
      setDescription(secret.description)
    }

    fetchData(secretId, session.token).catch(console.error)
  }, [])

  const formSubmit = async (event) => {
    event.preventDefault()

    const payload = {
      name: event.target.name.value,
      description: event.target.description.value
    }

    const response = await updateSecret(secretId, session.token, payload)
    setResponse(response)

    event.target.name.value = ""
    event.target.description.value = ""

    setIsOpen(false)

    navigate(`/secrets/${secretId}`)
  }

  return (
    <Dialog title="Edit" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
      <div className="error">
        {response?.error && <code>{response.error}</code>}
      </div>
      <form method="post" onSubmit={formSubmit}>
        <label>Name</label>
        <input name="name" required={true} value={name} onChange={(e) => { setName(e.target.value) }} />
        <label>Description</label>
        <textarea name="description" value={description} onChange={(e) => { setDescription(e.target.value) }} />
        <input name="submit" type="submit" value="Update" />
      </form>
    </Dialog>
  )
}
