import { createBrowserRouter, RouterProvider } from "react-router-dom"
import AuthContext from "./AuthContext"
import { useState, useContext } from "react"

// layouts
import MainLayout from "./layouts/MainLayout"

// pages
import Home from "./pages/Home"
import Signup, { SignupAction } from "./pages/Signup"
import SecretsIndex, { SecretsLoader } from "./pages/SecretsIndex"
import SecretsShow from "./pages/SecretsShow"

// /sign_up ->
//    /secrets [secrets showSecret() newSecret() logout()]
//    /secret/show [secret parts newPart()]
//    /secret/new [name description]
//      -> /secrets/show [secret parts newPart() decryptSecrets()]
//    /secret/:id/parts/new [key value password]
//    /secret/:id/parts/decrypt [password]
//    /logout

export default function Router() {
  const authContext = useContext(AuthContext)

  return (
    <RouterProvider router={createBrowserRouter([
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
            action: (args) => SignupAction({...args, authContext}),
          },
          {
            path: "/secrets",
            element: <SecretsIndex />,
            loader: (args) => SecretsLoader({...args, authContext}),
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
    ])} />
  )
}
