import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import "./assets/css/index.css";

import Header from "./components/header.tsx";
import Footer from "./components/footer.tsx";

import Home from "./pages/home.tsx";
import Checklist from "./pages/checklist.tsx";
import FlowDiagram from "./pages/flow_diagram.tsx";
import NotFound from "./pages/notfound.tsx";

const rootElement = document.getElementById("root") as HTMLDivElement;

if (rootElement) {
  const root = ReactDOM.createRoot(rootElement);
  root.render(
    <React.StrictMode>
      <BrowserRouter>
        <Header />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/checklist" element={<Checklist />} />
          <Route path="/flow_diagram" element={<FlowDiagram />} />
          <Route path="*" element={<NotFound />} />
        </Routes>
        <Footer />
      </BrowserRouter>
    </React.StrictMode>
  );
}
