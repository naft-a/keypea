import { createBrowserRouter, redirect, RouterProvider } from "react-router-dom"
import { logoutUser } from "./util/api"
import Session from "./util/session"

// layouts
import MainLayout from "./layouts/MainLayout"

// pages
import Home from "./pages/Home"
import Signup, { signupAction } from "./pages/Signup"
import SecretsIndex, { secretsLoader } from "./pages/SecretsIndex"
import SecretsShow from "./pages/SecretsShow"

const session = Session.initialize({
  token: null,
  dispatchAuthenticated: (param) => {
    const event = new CustomEvent("authenticated", {detail: param})
    self.dispatchEvent(event)
  }
})

const appRouter = createBrowserRouter([
  {
    path: "/",
    element: <MainLayout />,
    children: [
      {
        index: true,
        element: <Home />
      },
      {
        path: "/signup",
        element: <Signup />,
        action: signupAction,
      },
      {
        path: "/logout",
        loader: async () => {
          await logoutUser(session.token)

          session.token = null
          session.dispatchAuthenticated(false)

          return redirect("/")
        },
      },
      {
        path: "/secrets",
        element: <SecretsIndex />,
        loader: secretsLoader,
        children: [
          {
            path: ":id",
            element: <SecretsShow />,
            children: [
              {
                path: "parts/new",
                element: ""
              },
            ]
          }
        ]
      },
    ]
  }
])

export default function App() {
  return (
    <RouterProvider router={appRouter} />
  )
}
