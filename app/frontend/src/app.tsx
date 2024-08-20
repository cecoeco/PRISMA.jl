import { Router, Route } from "@solidjs/router";
import { ParentProps } from "solid-js";

import "./assets/css/app.css";

import Header from "./components/header.tsx";
import Home from "./pages/home.tsx";
import Checklist from "./pages/checklist.tsx";
import FlowDiagram from "./pages/flow_diagram.tsx";
import NotFound from "./pages/notfound.tsx";
import Footer from "./components/footer.tsx";

function AppLayout(props: ParentProps) {
  return (
    <>
      <Header />
      {props.children}
      <Footer />
    </>
  );
}

export default function App() {
  return (
    <Router root={AppLayout}>
      <Route path="/" component={Home} />
      <Route path="/checklist" component={Checklist} />
      <Route path="/flow_diagram" component={FlowDiagram} />
      <Route path="*" component={NotFound} />
    </Router>
  );
}
