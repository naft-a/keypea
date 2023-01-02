import { useRef, useState } from "react"
import {Form, redirect, useNavigate} from "react-router-dom"
import Dialog from "../components/Dialog"

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {Function} apiMethod
 * @param {Object} params
 * @param {String} returnPath
 * @return {JSX.Element}
 */
export default function DestroyDialog({ isOpen, setIsOpen, apiMethod, params, returnPath }) {
  const form = useRef(null)
  const navigate = useNavigate()
  const [confirmedOnce, setConfirmedOnce] = useState(false)

  const formSubmit = async (event) => {
    event.preventDefault()

    if (!confirmedOnce) {
      setConfirmedOnce(true)
    } else {
      await apiMethod(params)
      setIsOpen(false)

      navigate(returnPath, {state: "destroying"})
    }
  }

  return (
    <Dialog title="Destroying secret" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
      <Form ref={form} method="delete" onSubmit={formSubmit}>
        <div>
          {!confirmedOnce && <p>Are you sure you want to destroy this secret? This action is irreversible.</p>}
          {confirmedOnce && <p>Just checking again!</p>}
        </div>
        <input name="submit" type="submit"
               style={confirmedOnce ? {backgroundColor: "red"} : {}}
               value={confirmedOnce ? "Yes, destroy it" : "Destroy"} />
      </Form>
    </Dialog>
  )
}
