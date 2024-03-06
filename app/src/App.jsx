import "./assets/scss/App.scss";

import { lazy } from "solid-js";
import { Router, Route } from "@solidjs/router";

import Header from "./components/Header/Header.jsx";
import Footer from "./components/Footer.jsx";

const Home = lazy(() => import("./pages/Home/Home.jsx"));
const Checklist = lazy(() => import("./pages/Checklist/Checklist.jsx"));
const FlowDiagram = lazy(() => import("./pages/FlowDiagram/FlowDiagram.jsx"));
const Citation = lazy(() => import("./pages/Citation/Citation.jsx"));
const NotFound = lazy(() => import("./pages/NotFound/NotFound.jsx"));

/**
 * Renders the layout of the app.
 *
 * @param {object} props - the props passed to the component
 * @return {JSX.Element} the layout of the app
 */
function AppLayout(props) {
    return (
        <div class="app">
            <Header />
            <main class="app-content">
                {props.children}
            </main>
            <Footer />
        </div>
    )
}

/**
 * Renders the main application component with defined routes using Solid Router.
 *
 * @return {JSX} The rendered Solid component
 */
function App() {
    return (
        <Router root={AppLayout}>
            <Route path="/" component={Home} />
            <Route path="/checklist" component={Checklist} />
            <Route path="/flow-diagram" component={FlowDiagram} />
            <Route path="/citation" component={Citation} />
            <Route path="/*" component={NotFound} />
        </Router>
    )
}

export default App