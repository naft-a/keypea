import { useEffect, useState } from "react"

/***
 * @return {boolean}
 */
export function useAuthenticated() {
  const [authenticated, setAuthenticated] = useState(!!session.token)

  useEffect(() => {
    self.addEventListener("authenticated", () => { setAuthenticated(true) })
    self.addEventListener("unauthenticated", () => { setAuthenticated(false) })

    return () => {
      self.removeEventListener("authenticated",  () => { setAuthenticated(true) })
      self.removeEventListener("unauthenticated", () => { setAuthenticated(false) })
    }
  })

  return authenticated
}
