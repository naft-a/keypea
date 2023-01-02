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
    this.context.session = object
    this.context.addEventListener("authenticated", this.storeSession.bind(this))
    this.context.addEventListener("unauthenticated", this.destroySession.bind(this))

    return this.context.session
  }

  // private

  fetchSession() {

  }

  storeSession() {
    console.log(`storing ${JSON.stringify(this.context.session.token)}`)

    this.context.removeEventListener("authenticated", this.storeSession.bind(this))
  }

  destroySession(object, event) {
    console.log(`destroying ${JSON.stringify(this.context.session.token)}`)

    this.context.removeEventListener("unauthenticated", this.destroySession.bind(this))
  }

}
