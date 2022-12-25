import { createBrowserRouter, RouterProvider } from "react-router-dom"

// layouts
import MainLayout from "./layouts/MainLayout"

// pages
import Signup, { singupAction } from "./pages/Signup"
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
        action: singupAction,
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
