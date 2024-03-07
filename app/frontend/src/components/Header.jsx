import "../assets/scss/Header.scss";
import { createSignal } from "solid-js";
import { A } from "@solidjs/router";

/**
 * Create a link component with the given properties.
 *
 * @param {object} props - The properties for the link component
 * @return {JSX.Element} The link component
 */
const Link = (props) => (
    <A class="nav-link" href={props.href} activeClass="nav-link-active" end>
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
    };
    return (
        <header class="header">
            <h1 class="header-title">PRISMA.jl</h1>
            <nav class="navbar">
                <ul class="navbar-links">
                    <li class="navbar-item">
                        <Link class="navbar-item-link" href="/">
                            Home
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <a
                            class="navbar-item-link"
                            href="https://cecoeco.github.io/PRISMA.jl/app"
                            target="_blank"
                        >
                            Docs
                        </a>
                    </li>
                    <li class="navbar-item">
                        <Link class="navbar-item-link" href="/checklist">
                            Checklist
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <Link class="navbar-item-link" href="/flow_diagram">
                            Flow Diagram
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <Link class="navbar-item-link" href="/citation">
                            Citation
                        </Link>
                    </li>
                    <li class="github-container">
                        <a
                            class="github-link"
                            href="https://github.com/cecoeco/PRISMA.jl"
                            target="_blank"
                        >
                            <img
                                class="github-logo"
                                src="src/assets/svg/github-mark.svg"
                                alt="github logo"
                            />
                            <label class="github-text">Github</label>
                        </a>
                    </li>
                    <li class="theme-button-container">
                        <button class="theme-button" onClick={toggleTheme}>
                            {isLightTheme() ? (
                                <img
                                    class="theme-button-icon"
                                    src="src/assets/svg/sun.svg"
                                    alt="sun icon for light mode"
                                />
                            ) : (
                                <img
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
