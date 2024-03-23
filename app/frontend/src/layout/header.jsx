import "../assets/scss/header.scss";
import { createSignal, createEffect } from "solid-js";
import { A } from "@solidjs/router";

/**
 * Create a link component with the given properties.
 *
 * @param {object} props - The properties for the link component
 * @return {JSX.Element} The link component
 */
const Link = (props) => (
    <A
        class="nav-link"
        href={props.href}
        activeClass="nav-link-active"
        end
    >
        {props.children}
    </A>
);

/**
 * Renders the header component with a toggle theme button.
 *
 * @return {JSX.Element} The header component JSX
 */
function Header() {
    const [isLightTheme, setIsLightTheme] = createSignal(true);

    const toggleTheme = () => {
        setIsLightTheme(!isLightTheme());
        const theme = isLightTheme() ? "light" : "dark";
        document.documentElement.setAttribute("data-theme", theme);
    };

    createEffect(() => {
        const prefersDarkMode = window.matchMedia(
            "(prefers-color-scheme: dark)"
        ).matches;
        setIsLightTheme(!prefersDarkMode);
        const theme = prefersDarkMode ? "dark" : "light";
        document.documentElement.setAttribute("data-theme", theme);
    });

    return (
        <header class="header">
            <div class="header-title-container">
                <img
                    draggable="false"
                    class="header-logo"
                    src="src/assets/svg/logo.svg"
                    alt="logo"
                />
                <h1 class="header-title">PRISMA.jl</h1>
            </div>
            <nav class="navbar">
                <ul class="navbar-links">
                    <li class="navbar-item" title="Home">
                        <Link class="navbar-item-link" href="/">
                            Home
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <a
                            class="navbar-item-link"
                            href="https://cecoeco.github.io/PRISMA.jl/app"
                            target="_blank"
                            rel="noopener noreferrer"
                            title="Documentation"
                        >
                            Documentation
                            <svg
                                class="navbar-item-icon"
                                viewBox="0 0 1024 1024"
                                xmlns="http://www.w3.org/2000/svg"
                            >
                                <path d="M832 481.156c-22.088.01-39.99 17.912-40 40V920H104V232h398.844c22.09 0 40-17.91 40-40s-17.91-40-40-40H64c-22.09 0-40 17.91-40 40v768c.01 22.087 17.913 39.99 40 40h768c22.083-.02 39.98-17.917 40-39.998V521.156c-.01-22.088-17.912-39.99-40-40zM999.936 61.344C998.48 40.604 981.44 24.294 960.53 24H640c-22.09 0-40 17.91-40 40s17.91 40 40 40h223.437L355.72 611.688c-7.252 7.243-11.738 17.254-11.738 28.312 0 22.1 17.916 40.017 40.017 40.017 11.042 0 21.04-4.473 28.28-11.706L920 160.56V384c0 22.09 17.908 40 40 40s40-17.91 40-40V64.278c0-1 0-1.968-.065-2.936z" />
                            </svg>
                        </a>
                    </li>
                    <li class="navbar-item" title="Checklist">
                        <Link class="navbar-item-link" href="/checklist">
                            Checklist
                        </Link>
                    </li>
                    <li class="navbar-item" title="Flow Diagram">
                        <Link class="navbar-item-link" href="/flow_diagram">
                            Flow Diagram
                        </Link>
                    </li>
                    <li class="navbar-item" title="Citation">
                        <Link class="navbar-item-link" href="/citation">
                            Citation
                        </Link>
                    </li>
                    <li class="github-container">
                        <a
                            class="github-link"
                            href="https://github.com/cecoeco/PRISMA.jl"
                            target="_blank"
                            rel="noopener noreferrer"
                            title="Github"
                        >
                            <img
                                draggable="false"
                                class="github-logo"
                                src="src/assets/svg/github.svg"
                                alt="github logo"
                            />
                            <span class="github-text">Github</span>
                        </a>
                    </li>
                    <li class="theme-button-container">
                        <button
                            class="theme-button"
                            onClick={toggleTheme}
                            title="Toggle theme"
                            aria-label="Toggle theme"
                            aria-pressed={isLightTheme()}
                        >
                            {isLightTheme() ? (
                                <img
                                    draggable="false"
                                    class="theme-button-icon"
                                    src="src/assets/svg/sun.svg"
                                    alt="sun icon for light mode"
                                />
                            ) : (
                                <img
                                    draggable="false"
                                    class="theme-button-icon"
                                    src="src/assets/svg/moon.svg"
                                    alt="moon icon for dark mode"
                                />
                            )}
                        </button>
                    </li>
                </ul>
            </nav>
        </header>
    );
}

export default Header;
