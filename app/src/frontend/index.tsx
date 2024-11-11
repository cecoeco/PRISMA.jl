import ReactDOM from "react-dom/client";
import App from "./app.tsx";
import "./assets/scss/index.scss";

const container = document.getElementById("root") as HTMLElement;
if (!container) throw new Error("Root container missing in index.html");
const root = ReactDOM.createRoot(container);
root.render(<App />);
