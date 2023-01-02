export default class Session {
  /**
   * @param {Window} context
   */
  constructor(context) {
    this.context = context
  }

  /**
   * @param {Object} object
   * @return {Object}
   */
  static initialize(object) {
    return new Session(window).initialize(object)
  }

  /**
   * @param {Object} object
   * @return {Object}
   */
  initialize(object) {
    this.context.addEventListener("authenticated", this.storeSession.bind(this))
    this.context.addEventListener("unauthenticated", this.destroySession.bind(this))

    const token = this.fetchSessionToken()
    if (!token) {
      this.destroySession()
    }

    object.token = token
    this.context.session = object

    return this.context.session
  }

  // private

  fetchSessionToken() {
    const rawSession = sessionStorage.getItem("authSession")
    const session = JSON.parse(rawSession)

    if (!session) { return null }

    const nowTime = new Date()

    if (nowTime >= new Date(session.expiry)) { return null }

    return session.token
  }

  storeSession() {
    const nowTime = new Date()
    const expTime = nowTime.setMinutes(nowTime.getMinutes() + 30)

    const data = {
      expiry: expTime,
      token: this.context.session.token
    }
    sessionStorage.setItem("authSession", JSON.stringify(data))

    this.context.removeEventListener("authenticated", this.storeSession.bind(this))
  }

  destroySession() {
    sessionStorage.removeItem("authSession")

    this.context.removeEventListener("unauthenticated", this.destroySession.bind(this))
  }

}
