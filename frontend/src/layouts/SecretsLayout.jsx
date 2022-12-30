import {Link, matchRoutes, Outlet, useLocation, useParams} from "react-router-dom"
import { useEffect, useState, useRef } from "react"
import DecryptDialog from "../dialogs/DecryptDialog"
import EditSecretDialog from "../dialogs/EditSecretDialog.jsx";

export default function SecretsLayout() {
  const params = useParams()
  const location = useLocation()

  const [showEditDialog, setShowEditDialog] = useState(false)
  const [showDecryptDialog, setShowDecryptDialog] = useState(false)

  const [currentPath, setCurrentPath] = useState("")
  const [isSecretPath, setIsSecretPath] = useState(false)
  const [isPartsPath, setIsPartsPath] = useState(false)

  const secretRoute = [{path: "/secrets/:id"}]
  const partsRoute = [{path: "/secrets/:id/parts"}]

  useEffect(() => {
    const matchSecretRoute = matchRoutes(secretRoute, location)
    const matchPartsRoute = matchRoutes(partsRoute, location)

    setIsSecretPath(matchSecretRoute?.length > 0)
    setIsPartsPath(matchPartsRoute?.length > 0)
    setCurrentPath(location.pathname)
  }, [location])

  const render = (currentPath) => {
    // SecretNew
    if (currentPath === "/secrets/new") {
      return (
        <>
          <Link to="/secrets">{"[ < Back ]"}</Link>
        </>
      )
    }

    // PartNew
    if (currentPath === `/secrets/${params.id}/parts/new`) {
      return (
        <>
          <Link to={`/secrets/${params.id}/parts`}>{"[ < Back ]"}</Link>
        </>
      )
    }

    // SecretShow
    if (isSecretPath) {
      return (
        <>
          <Link to="/secrets">{"[ < Back ]"}</Link>
          <Link to="#" onClick={() => { setShowEditDialog(true) }}>[ Edit ]</Link>
          <Link to={`${currentPath}/parts`}>[ Parts ]</Link>
        </>
      )
    }

    // PartShow
    if (isPartsPath) {
      return (
        <>
          <Link to={`/secrets/${params.id}`}>{"[ < Back ]"}</Link>
          <Link to={`${currentPath}/new`} hidden={isSecretPath}>[ New ]</Link>
          <Link to="#" onClick={() => { setShowDecryptDialog(true) }} title="Decrypt">[ Decrypt ]</Link>
        </>
      )
    }

    // SecretIndex
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
        {render(currentPath)}
      </nav>

      <Outlet />

      {(isPartsPath && showDecryptDialog) &&
        <DecryptDialog
          isOpen={showDecryptDialog}
          setIsOpen={setShowDecryptDialog}
          secretId={params.id}
          returnPath={`/secrets/${params.id}/parts`} />}

      {(isSecretPath && showEditDialog) &&
        <EditSecretDialog
          isOpen={showEditDialog}
          setIsOpen={setShowEditDialog}
          secretId={params.id} />}
    </div>
  )
}
