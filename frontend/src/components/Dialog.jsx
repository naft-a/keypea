import { useEffect, useRef, useState } from "react"

export default function Dialog({children, ...props}) {
  const dialogElement = useRef(null)
  const [isOpen, setIsOpen] = useState(false)

  useEffect(() => {
    const triggerElement = document.querySelector(`#${props.identifier}`)

    const openDialog = () => {
      setIsOpen(true)
    }

    const closeDialogOnEscape = (event) => {
      if (event.key === "Escape") {
        setIsOpen(false)
      }
    }

    triggerElement.addEventListener("click", openDialog)
    document.addEventListener("keydown", closeDialogOnEscape, false)

    return () => {
      triggerElement.addEventListener("click", openDialog)
      document.removeEventListener("keydown", closeDialogOnEscape, false)
    };
  })

  useEffect(() => {
    if (isOpen) {
      dialogElement.current.showModal()
    } else {
      dialogElement.current.close()
    }
  }, [isOpen])

  return (
    <dialog id="dialog" ref={dialogElement}>
      <header>
        <div>
          <strong>
            { props.name }
          </strong>
        </div>
        <div>
          <button value="close" onClick={(_e) => { setIsOpen(false) }} />
        </div>
      </header>
      { children }
    </dialog>
  )
}
