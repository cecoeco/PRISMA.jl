import "./assets/scss/app.scss";

import { lazy } from "solid-js";
import { Router, Route } from "@solidjs/router";

import Header from "./components/header.jsx";
import Footer from "./components/footer.jsx";

const Home = lazy(() => import("./pages/home.jsx"));
const Checklist = lazy(() => import("./pages/checklist.jsx"));
const FlowDiagram = lazy(() => import("./pages/flow_diagram.jsx"));
const Citation = lazy(() => import("./pages/citation.jsx"));
const NotFound = lazy(() => import("./pages/notfound.jsx"));

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
            <main class="app-content">{props.children}</main>
            <Footer />
        </div>
    );
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
            <Route path="/flow_diagram" component={FlowDiagram} />
            <Route path="/citation" component={Citation} />
            <Route path="/*" component={NotFound} />
        </Router>
    );
}

export default App;
