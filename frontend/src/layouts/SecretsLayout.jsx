import { useEffect, useState } from "react"
import { Link, matchRoutes, Outlet, useLocation, useParams } from "react-router-dom"
import { useAuthenticated } from "../util/hooks"
import DecryptDialog from "../dialogs/DecryptDialog"
import EditSecretDialog from "../dialogs/EditSecretDialog"
import DestroyDialog from "../dialogs/DestroyDialog"
import { deleteSecret } from "../util/api"

export default function SecretsLayout() {
  const params = useParams()
  const location = useLocation()
  const authenticated = useAuthenticated()

  const [showEditDialog, setShowEditDialog] = useState(false)
  const [showDecryptDialog, setShowDecryptDialog] = useState(false)
  const [showDestroyDialog, setShowDestroyDialog] = useState(false)

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
    // SecretsNew
    if (currentPath === "/secrets/new") {
      return (
        <>
          <Link to="/secrets">{"[ < Back ]"}</Link>
        </>
      )
    }

    // PartsNew
    if (currentPath === `/secrets/${params.id}/parts/new`) {
      return (
        <>
          <Link to={`/secrets/${params.id}/parts`}>{"[ < Back ]"}</Link>
        </>
      )
    }

    // SecretsShow
    if (isSecretPath) {
      return (
        <>
          <Link to="/secrets">{"[ < Back ]"}</Link>
          <Link to="#" onClick={() => { setShowEditDialog(true) }}>[ Edit ]</Link>
          <Link to={`${currentPath}/parts`}>[ Parts ]</Link>
          <Link to="#" className="destroy" onClick={() => { setShowDestroyDialog(true) }}>[ Destroy ]</Link>
        </>
      )
    }

    // PartsIndex
    if (isPartsPath) {
      return (
        <>
          <Link to={`/secrets/${params.id}`}>{"[ < Back ]"}</Link>
          <Link to={`${currentPath}/new`} hidden={isSecretPath}>[ New ]</Link>
          <Link to="#" onClick={() => { setShowDecryptDialog(true) }} title="Decrypt">[ Decrypt ]</Link>
        </>
      )
    }

    // SecretsIndex
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
        {authenticated &&
          render(currentPath)}
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

      {(isSecretPath && showDestroyDialog) &&
        <DestroyDialog
          isOpen={showDestroyDialog}
          setIsOpen={setShowDestroyDialog}
          apiMethod={deleteSecret}
          params={{secretId: params.id}}
          returnPath={`/secrets`}/>}
    </div>
  )
}
