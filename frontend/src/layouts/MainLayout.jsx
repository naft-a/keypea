import {useState, useEffect, useRef} from "react";
import { Outlet, NavLink, Link, useLocation } from "react-router-dom"
import LoginDialog from "../dialogs/LoginDialog"
import Logo from "../assets/pea.svg"

export default function MainLayout() {
  const location = useLocation()
  const [authenticated, setAuthenticated] = useState(false)
  const [showDialog, setShowDialog] = useState(!authenticated)

  useEffect(() => {
    self.addEventListener("authenticated", (event) => { setAuthenticated(event.detail) })

    return () => {
      self.removeEventListener("authenticated",  (event) => { setAuthenticated(event.detail) })
    }
  })

  return (
    <>
      <header>
        <div id="heading">
          <h1>Keypea</h1>
          <img src={Logo} alt="Your SVG" width={70} />
        </div>
        <nav>
          <NavLink to="/">[ Home ]</NavLink>
          <Link to="#" onClick={() => { setShowDialog(true) }} hidden={authenticated}>[ Login ]</Link>
          <NavLink to="/signup" hidden={authenticated}>[ Signup ]</NavLink>
          <NavLink to="/secrets" hidden={!authenticated}>[ Secrets ]</NavLink>
          <NavLink to="/logout" hidden={!authenticated}>[ Logout ]</NavLink>
        </nav>
      </header>
      <main>
        <Outlet />

        {showDialog &&
          <LoginDialog
            isOpen={showDialog}
            setIsOpen={setShowDialog}
            returnPath={location.pathname}/>}
      </main>
    </>
  )
}
