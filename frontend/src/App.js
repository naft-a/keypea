// import logo from './logo.svg';
// import './App.css';
//
// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }
//
// export default App;

import logo from './logo.svg';
import './App.css';
import React, { useState, useEffect } from 'react';

function App() {
  const [csrfToken, setCsrfToken] = useState("");

  async function fetchCsrfToken() {
    const urlEndpoint = "http://localhost:9292/core/v1/auth/github/signin";
    const response = await fetch(urlEndpoint, {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer example"
      }
    });

    const data = await response.json();
    const token = data.csrf_token;
    console.log(token);
    setCsrfToken(token);
  }

  useEffect(() => {
    fetchCsrfToken();
  }, []);

  async function handleSubmit(event) {
    event.preventDefault();

    const urlEndpoint = "http://localhost:9292/core/v1/auth/github";

    try {
      const response = await fetch(urlEndpoint, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer example",
          "X-CSRF-Token": csrfToken
        }
      });

      await response;
    } catch (err) {
      console.log(err);
    }
  }

  return (
    <div>
      <h1>Hello World!</h1>
    </div>
  );
}

export default App;
