import { useState, useEffect } from "react";
import { Outlet, NavLink, Link } from "react-router-dom"
import LoginDialog from "../dialogs/LoginDialog.jsx";

export default function MainLayout() {
  const [authenticated, setAuthenticated] = useState(false)

  useEffect(() => {
    self.addEventListener("authenticated", (event) => { setAuthenticated(event.detail) })

    return () => {
      self.removeEventListener("authenticated",  (event) => { setAuthenticated(event.detail) })
    }
  })

  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">[ Home ]</NavLink>
          <Link to="#" id="loginDialog" hidden={authenticated}>[ Login ]</Link>
          <NavLink to="/signup" hidden={authenticated}>[ Signup ]</NavLink>
          <NavLink to="/secrets" hidden={!authenticated}>[ Secrets ]</NavLink>
          <NavLink to="/logout" hidden={!authenticated}>[ Logout ]</NavLink>
        </nav>
      </header>
      <main>
        <Outlet />

        <LoginDialog show={!authenticated} />
      </main>
    </>
  )
}
