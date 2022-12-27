import { Outlet, NavLink } from "react-router-dom"
import LoginDialog from "../pages/LoginDialog";

export default function MainLayout() {
  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">Home</NavLink>
          <NavLink to="#" id="loginDialog">Login</NavLink>
          <NavLink to="/signup">Signup</NavLink>
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
