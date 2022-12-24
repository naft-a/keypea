import { Outlet, Link, NavLink } from "react-router-dom"
import {useState} from "react";

export default function MainLayout() {
  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">Home</NavLink>
          <Link to="/signup">Signup</Link>
        </nav>
      </header>
      <main>
        <Outlet />
      </main>
    </>
  )
}
