import { Outlet, NavLink } from "react-router-dom"
import LoginDialog from "../pages/LoginDialog";

export default function MainLayout() {
  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">Home</NavLink>
          <NavLink to="#" id="loginDialog" hidden={window.authenticated}>Login</NavLink>
          <NavLink to="/signup" hidden={window.authenticated}>Signup</NavLink>
          <NavLink to="/secrets">Secrets</NavLink>
        </nav>
      </header>
      <main>
        <Outlet />

        <LoginDialog />
      </main>
    </>
  )
}
