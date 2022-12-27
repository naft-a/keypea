import { createBrowserRouter, RouterProvider } from "react-router-dom"

// layouts
import MainLayout from "./layouts/MainLayout"

// pages
import Home from "./pages/Home"
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
        index: true,
        element: <Home />
      },
      {
        path: "/signup",
        element: <Signup />,
        action: signupAction,
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
