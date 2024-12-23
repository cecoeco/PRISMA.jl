import React from "react";
import Header from "./components/header.tsx";
import Footer from "./components/footer.tsx";
import Checklist from "./components/checklist.tsx";
import FlowDiagram from "./components/flow_diagram.tsx";

export default function App(): React.JSX.Element {
  return (
    <React.StrictMode>
      <Header />
      <Checklist />
      <FlowDiagram />
      <Footer />
    </React.StrictMode>
  );
}
