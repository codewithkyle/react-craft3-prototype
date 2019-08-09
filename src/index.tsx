import * as React from "react";
import { render } from "react-dom";

function App() {
  return (
    <div className="App">
      <h1>Hello CodeSandbox</h1>
      <h2>Start editing to see some magic happen!</h2>
    </div>
  );
}

const rootElement = document.body.querySelector('root-view');
render(<App />, rootElement);
