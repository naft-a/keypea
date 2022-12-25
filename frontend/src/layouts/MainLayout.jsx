import { Outlet, Link, NavLink } from "react-router-dom"
import {useState} from "react";

export default function MainLayout() {
  return (
    <>
      <header>
        <nav>
          <h1>Keypea</h1>
          <NavLink to="/">Home</NavLink>
          <NavLink to="/signup">Signup</NavLink>
          <NavLink to="/secrets">Secrets</NavLink>
        </nav>
      </header>
      <main>
        <Outlet />
      </main>
    </>
  )
}
