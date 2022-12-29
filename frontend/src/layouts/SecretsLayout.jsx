import {Link, matchRoutes, NavLink, Outlet, useLocation} from "react-router-dom"
import {useEffect, useState} from "react";

export default function SecretsLayout({ params }) {
  const location = useLocation()

  const [currentPath, setCurrentPath] = useState("")
  const [isSecretPath, setIsSecretPath] = useState(false)
  const [isPartsPath, setIsPartsPath] = useState(false)

  const secretRoute = [{ path: "/secrets/:id" }]
  const partsRoute = [{ path: "/secrets/:id/parts"}]

  useEffect(() => {
    const matchSecretRoute = matchRoutes(secretRoute, location)
    const matchPartsRoute = matchRoutes(partsRoute, location)

    setIsSecretPath(matchSecretRoute?.length > 0)
    setIsPartsPath(matchPartsRoute?.length > 0)
    setCurrentPath(location.pathname)
  }, [location])

  const renderLinks = () => {
    if (isSecretPath) {
      return (
        <>
          <Link to="/secrets">{"[ < Back ]"}</Link>
          <Link to={`${currentPath}/edit`}>[ Edit ]</Link>
          <Link to={`${currentPath}/parts`}>[ Parts ]</Link>
        </>
      )
    }

    if (isPartsPath) {
      return (
        <>
          <Link to={currentPath.substring(0, currentPath.lastIndexOf('/'))}>{"[ < Back ]"}</Link>
          <Link to={`${currentPath}/new`} hidden={isSecretPath}>[ New ]</Link>
          <Link to={`${currentPath}/decrypt`} id="decryptDialog" title="Decrypt">🔓</Link>
        </>
      )
    }

    return (
      <>
        <Link to="/secrets/new" hidden={isSecretPath}>[ New ]</Link>
      </>
    )
  }

  return (
    <div>
      <nav>
        <hr></hr>
        {renderLinks()}
      </nav>

      <Outlet />
    </div>
  )
}
