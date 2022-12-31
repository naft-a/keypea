import { useRef, useState } from "react"
import { Form, useNavigate } from "react-router-dom"
import Dialog from "../components/Dialog"
import { deleteSecret } from "../util/api"

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {String} secretId
 * @return {JSX.Element}
 */
export default function DestroyDialog({ isOpen, setIsOpen, secretId }) {
  const form = useRef(null)
  const navigate = useNavigate()
  const [confirmedOnce, setConfirmedOnce] = useState(false)

  const formSubmit = async (event) => {
    event.preventDefault()

    console.log("Submitted")
    console.log(confirmedOnce)

    if (!confirmedOnce) {
      setConfirmedOnce(true)
    } else {
      await deleteSecret(secretId)
      setIsOpen(false)

      navigate("/secrets")
    }
  }

  return (
    <Dialog title="Destroying secret" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
      <Form ref={form} method="delete" onSubmit={formSubmit}>
        {!confirmedOnce && <p>Are you sure you want to destroy this secret? This action is irreversible.</p>}
        {confirmedOnce && <p>Just checking again!</p>}
        <input name="submit" type="submit"
               style={confirmedOnce ? {backgroundColor: "red"} : {}}
               value={confirmedOnce ? "Yes, destroy it" : "Destroy"} />
      </Form>
    </Dialog>
  )
}
