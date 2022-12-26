import { createBrowserRouter, RouterProvider } from "react-router-dom"

// layouts
import MainLayout from "./layouts/MainLayout"

// pages
import { loginAction } from "./pages/LoginDialog";
import Signup, { signupAction } from "./pages/Signup"
import SecretsIndex, { secretsLoader } from "./pages/SecretsIndex"
import SecretsShow from "./pages/SecretsShow"

// /sign_up ->
 //    /secrets [secrets showSecret() newSecret() logout()]
 //    /secret/show [secret parts newPart()]
 //    /secret/new [name description]
 //      -> /secrets/show [secret parts newPart() decryptSecrets()]
 //    /secret/:id/parts/new [key value password]
 //    /secret/:id/parts/decrypt [password]
 //    /logout

const appRouter = createBrowserRouter([
  {
    path: "/",
    element: <MainLayout />,
    children: [
      {
        path: "/signup",
        element: <Signup />,
        action: signupAction,
      },
      {
        path: "/unlock",
        element: null,
        action: null
      },
      {
        path: "/login",
        element: null, // rendered in Main Layout
        action: loginAction
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
              {
                path: "parts/decrypt",
                element: ""
              }
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
