import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";

import Header from "./components/header.tsx";
import Footer from "./components/footer.tsx";

import Home from "./pages/home.tsx";
import Checklist from "./pages/checklist.tsx";
import FlowDiagram from "./pages/flow_diagram.tsx";
import NotFound from "./pages/notfound.tsx";

const App: React.FC = () => {
  return (
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
};

export default App;
