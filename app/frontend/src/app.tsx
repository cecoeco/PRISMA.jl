import React, { StrictMode } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { createRoot } from "react-dom/client";

import "./assets/css/app.css";

import Header from "./components/header.tsx";
import Home from "./pages/home.tsx";
import Checklist from "./pages/checklist.tsx";
import FlowDiagram from "./pages/flow_diagram.tsx";
import NotFound from "./pages/notfound.tsx";
import Footer from "./components/footer.tsx";

const App: React.FC = () => {
  return (
    <Router>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/checklist" element={<Checklist />} />
        <Route path="/flow_diagram" element={<FlowDiagram />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
      <Footer />
    </Router>
  );
};

const root = createRoot(document.getElementById("root")!);

root.render(
  <StrictMode>
    <App />
  </StrictMode>
);
