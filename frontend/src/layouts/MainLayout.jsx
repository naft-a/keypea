import { useState } from "react";
import { Outlet, NavLink, Link, useLocation } from "react-router-dom"
import { useAuthenticated } from "../util/hooks"
import LoginDialog from "../dialogs/LoginDialog"
import Logo from "../assets/pea.svg"

export default function MainLayout() {
  const location = useLocation()
  const authenticated = useAuthenticated()
  const [showDialog, setShowDialog] = useState(!authenticated)

  return (
    <>
      <header>
        <div id="heading">
          <h1>Keypea</h1>
          <img src={Logo} alt="Keypea" width={70} />
        </div>
        <nav>
          <NavLink to="/">[ Home ]</NavLink>

          {authenticated && <>
            <NavLink to="/secrets">[ Secrets ]</NavLink>
            <NavLink to="/logout">[ Logout ]</NavLink>
          </>}

          {!authenticated && <>
            <Link to="#" onClick={() => { setShowDialog(true) }}>[ Login ]</Link>
            <NavLink to="/signup" >[ Signup ]</NavLink>
          </>}
        </nav>
      </header>
      <main>
        <Outlet />

        {showDialog &&
          <LoginDialog
            isOpen={showDialog}
            setIsOpen={setShowDialog}
            returnPath={"/secrets"}/>}
      </main>
    </>
  )
}
