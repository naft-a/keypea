import { useEffect, useRef } from "react"

export default function Dialog({children, ...props}) {
  const dialog = useRef(null)

  const openDialog = () => {
    dialog.current.showModal()
  }

  const closeDialog = () => {
    dialog.current.close()
  }

  useEffect(() => {
    dialog.current.removeAttribute('open')

    if (props.show) { openDialog() }

    const triggerElement = document.querySelector(`#${props.identifier}`)
    triggerElement?.addEventListener("click", openDialog)

    const closeDialogOnEscape = (event) => {
      if (event.key === "Escape") {
        closeDialog()
      }
    }

    document.addEventListener("keydown", closeDialogOnEscape, false)
    return () => {
      triggerElement?.removeEventListener("click", openDialog)
      document.removeEventListener("keydown", closeDialogOnEscape, false)
    };
  }, [])

  return (
    <dialog id="dialog" ref={dialog}>
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
