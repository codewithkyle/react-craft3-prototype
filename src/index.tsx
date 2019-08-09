import * as React from "react";
import { render } from "react-dom";

function App() {
  return (
    <div className="App">
      <h1>Hello world!</h1>
    </div>
  );
}

const rootElement = document.body.querySelector('root-view');
render(<App />, rootElement);
