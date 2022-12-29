import { Outlet, NavLink, Link } from "react-router-dom"
import LoginDialog from "../dialogs/LoginDialog.jsx";

export default function MainLayout() {
  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">[ Home ]</NavLink>
          <Link to="#" id="loginDialog">[ Login ]</Link>
          <NavLink to="/signup">[ Signup ]</NavLink>
          <NavLink to="/secrets">[ Secrets ]</NavLink>
        </nav>
      </header>
      <main>
        <Outlet />

        <LoginDialog />
      </main>
    </>
  )
}
