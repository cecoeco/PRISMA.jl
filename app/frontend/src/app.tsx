import { render } from "solid-js/web";
import { Router, Route } from "@solidjs/router";
import { ParentProps } from "solid-js";
import { MetaProvider, Meta, Link, Title } from "@solidjs/meta";

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

function App() {
  return (
    <MetaProvider>
      <Router root={AppLayout}>
        <Meta charset="utf-8" />
        <Meta name="viewport" content="width=device-width, initial-scale=1" />
        <Meta name="description" content="PRISMA Web App - Checklist and Flow Diagram" />
        <Title>PRISMA Web App</Title>
        <Link rel="icon" href="./assets/favicon.ico" />
        <Route path="/" component={Home} />
        <Route path="/checklist" component={Checklist} />
        <Route path="/flow_diagram" component={FlowDiagram} />
        <Route path="*" component={NotFound} />
      </Router>
    </MetaProvider>
  );
}

render(() => <App />, document.body);
