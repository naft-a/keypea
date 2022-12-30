import Dialog from "../components/Dialog.jsx"
import { useEffect, useState } from "react"
import { useNavigate } from "react-router-dom"
import {getSecret, getSecrets, updateSecret} from "../util/api"

export default function EditSecretDialog({ secretId }) {
  const navigate = useNavigate()

  const [response, setResponse] = useState(null)
  const [name, setName] = useState("")
  const [description, setDescription] = useState("")

  useEffect(() => {
    const fetchData = async (id, token) => {
      const { name, description } =  await getSecret(id, token)

      setName(name)
      setDescription(description)
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
    event.target.parentElement.close()

    navigate(`/secrets/${secretId}`)
  }

  return (
    <Dialog identifier="editSecretDialog" name="Edit">
      <div className="error">
        {response?.error && <code>{response.error}</code>}
      </div>
      <form method="post" onSubmit={formSubmit}>
        <label>Name</label>
        <input name="name" required={true} value={name} onChange={(e) => { setName(e.target.value) }} />
        <label>Description</label>
        <textarea name="description" required={true} value={description} onChange={(e) => { setDescription(e.target.value) }} />
        <input name="submit" type="submit" value="Update" />
      </form>
    </Dialog>
  )
}
