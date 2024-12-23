import "./assets/css/index.css";

import ReactDOM from "react-dom/client";
import App from "./app.tsx";

const rootElement = document.getElementById("root") as HTMLDivElement;

if (rootElement) {
  const root = ReactDOM.createRoot(rootElement);
  root.render(<App />);
}
