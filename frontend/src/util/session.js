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

    return this.context.session
  }
}
