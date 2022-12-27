import { useEffect, useRef, useState } from "react"

export default function Dialog({children, ...props}) {
  const dialogElement = useRef(null)

  const openDialog = () => {
    dialogElement.current.showModal()
  }

  const closeDialog = () => {
    dialogElement.current.close()
  }

  useEffect(() => {
    dialogElement.current.removeAttribute('open')
    if (props.show) {
      openDialog()
    }

    const triggerElement = document.querySelector(`#${props.identifier}`)

    const closeDialogOnEscape = (event) => {
      if (event.key === "Escape") {
        closeDialog()
      }
    }

    triggerElement.addEventListener("click", openDialog)
    document.addEventListener("keydown", closeDialogOnEscape, false)

    return () => {
      triggerElement.addEventListener("click", openDialog)
      document.removeEventListener("keydown", closeDialogOnEscape, false)
    };
  }, [])

  return (
    <dialog id="dialog" ref={dialogElement}>
      <header>
        <div>
          <strong>
            { props.name }
          </strong>
        </div>
        <div>
          <button value="close" onClick={closeDialog} />
        </div>
      </header>
      { children }
    </dialog>
  )
}
