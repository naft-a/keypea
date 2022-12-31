import Dialog from "../components/Dialog.jsx"
import {useEffect, useState} from "react";

/**
 * @param {Boolean} isOpen
 * @param {Function} setIsOpen
 * @param {Function} setPassword
 * @return {JSX.Element}
 */
export default function PasswordDialog({ isOpen, setIsOpen, setPassword }) {

  const formSubmit = async (event) => {
    event.preventDefault()

    setPassword(event.target.password.value)
    setIsOpen(false)

    event.target.password.value = ""
  }

  return (
    <Dialog title="Enter your password" isOpen={isOpen} onClose={() => { setIsOpen(false) }}>
      <form method="post" onSubmit={formSubmit}>
        <label>Password</label>
        <input name="password" type="password" required={true}/>
        <input name="submit" type="submit" value="Submit" />
      </form>
    </Dialog>
  )
}
