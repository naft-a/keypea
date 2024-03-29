import { createBrowserRouter, redirect, RouterProvider } from "react-router-dom"
import { logoutUser } from "./util/api"
import Session from "./util/session"

// layouts
import MainLayout from "./layouts/MainLayout"
import SecretsLayout from "./layouts/SecretsLayout"

// pages
import Home from "./pages/Home"
import Signup, { signupAction } from "./pages/Signup"
import SecretsIndex, { secretsLoader } from "./pages/SecretsIndex"
import SecretsShow, { secretLoader } from "./pages/SecretsShow"
import PartsIndex, { partsLoader } from "./pages/PartsIndex"
import PartsNew, { partsNewAction, partsNewLoader } from "./pages/PartsNew"
import SecretsNew, { secretsNewAction, secretsNewLoader } from "./pages/SecretsNew"

const session = Session.initialize({
  token: null,
  dispatchAuthenticated: () => {
    self.dispatchEvent(new Event("authenticated"))
  },
  dispatchUnauthenticated: () => {
    self.dispatchEvent(new Event("unauthenticated"))
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
          session.dispatchUnauthenticated()

          return redirect("/")
        },
      },
      {
        path: "/secrets",
        element: <SecretsLayout />,
        children: [
          {
            index: true,
            element: <SecretsIndex />,
            loader: secretsLoader
          },
          {
            path: "new",
            element: <SecretsNew />,
            loader: secretsNewLoader,
            action: secretsNewAction
          },
          {
            path: ":id",
            element: <SecretsShow />,
            loader: secretLoader
          },
          {
            path: ":id/parts",
            element: <PartsIndex />,
            loader: partsLoader,
          },
          {
            path: ":id/parts/new",
            element: <PartsNew />,
            loader: partsNewLoader,
            action: partsNewAction
          }
        ],
      }
    ]
  }
])

export default function App() {
  return (
    <RouterProvider router={appRouter} />
  )
}
