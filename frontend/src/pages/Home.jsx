import {NavLink} from "react-router-dom"
import GithubLight from "../assets/github-mark-white.png"
import GithubDark from "../assets/github-mark.png"

export default function Home() {
  const darkMode = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches

  return (
    <section id="content">
      <h2>What is it?</h2>
      <p>
        Keypea is an online wallet that holds all your secrets in an encrypted database designed to keep your secrets safe, ensuring that only you have access to your information.
      </p>
      <h2>How does it work?</h2>
      <p>
        To get started, you'll need to <NavLink to="/signup">create</NavLink> an account with a strong, secure password. It's important to keep your password safe by using a password manager or other secure method. Remember that if you lose your password, you'll also lose access to your data. The app uses <a href="https://en.wikipedia.org/wiki/Bcrypt" target="_blank">bcrypt</a> hashing to protect your password, which means that only the hashed version is compared during authentication.
      </p>
      <p>
        Create your first secret by describing what you'll be storing. Once your secret is created, you can add as many "parts" as needed to hold the actual data for encryption. Parts are simply key-value records that enable secure storage of your sensitive information.
      </p>
      <p>
        When you register with Keypea, the app creates an encryption key based on the password you provide. This key is then used to encrypt all parts you store in your secrets, and the encryption itself is done using the <a href="https://en.wikipedia.org/wiki/Advanced_Encryption_Standard" target="_blank">AES-256</a> cipher algorithm.
      </p>
      <br />
      <span>
        <a title="Go to repo" href="https://github.com/naft-a/keypea" target="_blank"><img src={darkMode ? GithubLight : GithubDark} alt="Github" width={30} /></a>
      </span>
      <p></p>
    </section>
  )
}
