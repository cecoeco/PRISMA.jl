import { MetaProvider, Title } from "@solidjs/meta";
import { Router } from "@solidjs/router";
import { FileRoutes } from "@solidjs/start";
import { Suspense } from "solid-js";
import "./app.css";

import Header from "./components/header";
import Footer from "./components/footer";

export default function App() {
    return (
        <Router
            root={props => (
                <MetaProvider>
                    <Title>PRISMA.jl</Title>
                    <Header />
                    <Suspense>{props.children}</Suspense>
                    <Footer />
                </MetaProvider>
            )}
        >
            <FileRoutes />
        </Router>
    );
}
