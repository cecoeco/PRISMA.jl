import { MetaProvider, Title } from "@solidjs/meta";
import { Router } from "@solidjs/router";
import { FileRoutes } from "@solidjs/start";
import { Suspense } from "solid-js";
import "../src/assets/scss/app.scss";

import Header from "./components/header";
import Footer from "./components/footer";

export default function App() {
    return (
        <Router
            root={props => (
                <MetaProvider>
                    <Title>PRISMA.jl</Title>
                    <Header />
                    <div class="app-content">
                        <Suspense>{props.children}</Suspense>
                    </div>
                    <Footer />
                </MetaProvider>
            )}
        >
            <FileRoutes />
        </Router>
    );
}