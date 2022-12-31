import { useEffect, useRef } from "react"

/**
 * @param {React.Component} children
 * @param {String} title
 * @param {Boolean} isOpen
 * @param {ReactEventHandler<HTMLDialogElement> | undefined} onClose
 * @return {JSX.Element}
 */
export default function Dialog({children, title, isOpen, onClose }) {
  const dialog = useRef(null)

  const openDialog = () => {
    dialog.current.showModal()
  }

  const closeDialog = () => {
    dialog.current.close()
  }

  useEffect(() => {
    dialog.current.removeAttribute('open')

    if (isOpen) {
      openDialog()
    } else {
      closeDialog()
    }
  }, [isOpen])

  return (
    <dialog ref={dialog} onClose={onClose}>
      <header>
        <div>
          <strong>
            { title }
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
