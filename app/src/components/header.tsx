import "../scss/header.scss";
import { createSignal } from "solid-js";
import { A } from "@solidjs/router";
import { FaSolidMagnifyingGlass } from "solid-icons/fa";
import { FaRegularCircleXmark } from "solid-icons/fa";
import { FaBrandsGithub } from "solid-icons/fa";
import { BsSun } from "solid-icons/bs";
import { BsMoon } from "solid-icons/bs";

const Link = (props: any) => (
    <A
        class="nav-link"
        href={props.href}
        activeClass="nav-link-active"
        end
    >
        {props.children}
    </A>
);

function Header() {
    const [searchText, setSearchText] = createSignal("");
    const [isLightTheme, setIsLightTheme] = createSignal(true);

    const handleSearchChange = (event: any) => {
        setSearchText(event.target.value);
    };

    const clearSearch = () => {
        setSearchText("");
    };

    const toggleTheme = () => {
        setIsLightTheme(!isLightTheme());
    };

    const submitSearch = (query: any) => {
        const encodedQuery = encodeURIComponent(query);
        window.location.href = `/search-results?query=${encodedQuery}`;
    };

    return (
        <header class="header">
            <div class="header-title-container">
                <h1 class="header-title">PRISMA.jl</h1>
            </div>

            <nav class="navbar">
                <ul class="navbar-links">
                    <li class="navbar-item">
                        <Link
                            class="navbar-item-link"
                            href="/"
                        >
                            Home
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <Link
                            class="navbar-item-link"
                            href="/checklist"
                        >
                            Checklist
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <Link
                            class="navbar-item-link"
                            href="/flow-diagram"
                        >
                            Flow Diagram
                        </Link>
                    </li>
                    <li class="navbar-item">
                        <Link
                            class="navbar-item-link"
                            href="/citation"
                        >
                            Citation
                        </Link>
                    </li>
                </ul>
            </nav>

            <div class="header-search-container">
                <div class="header-search-background">
                    <FaSolidMagnifyingGlass
                        class="header-search-icon"
                        onclick={(event) => {
                            event.preventDefault();
                            submitSearch(searchText());
                        }}
                    />
                    <input
                        class="header-search"
                        type="text"
                        placeholder="Search"
                        value={searchText()}
                        onInput={handleSearchChange}
                        onKeyPress={(event) => {
                            if (event.key === "Enter") {
                                event.preventDefault();
                                submitSearch(searchText());
                            }
                        }}
                    />
                    {searchText() ? (
                        <FaRegularCircleXmark
                            class="header-search-clear-icon"
                            onClick={clearSearch}
                        />
                    ) : (
                        <span class="header-search-clear-placeholder"></span>
                    )}
                </div>
            </div>

            <div class="github-container">
                <a
                    class="github-repo-link"
                    href="https://github.com/cecoeco/PRISMA.jl"
                    target="_blank"
                >
                    <button class="github-repo-button">
                        <FaBrandsGithub class="github-repo-icon" />
                        <label class="github-repo-text">Star</label>
                    </button>
                </a>
                <a
                    class="github-stars-link"
                    href="https://github.com/cecoeco/PRISMA.jl/stargazers"
                    target="_blank"
                >
                    <button class="github-stars-button">
                        <label class="github-stars-text">0</label>
                    </button>
                </a>
            </div>

            <div class="theme-button-container">
                <button
                    class="theme-button"
                    onClick={toggleTheme}
                >
                    {isLightTheme() ? (
                        <BsSun class="theme-button-icon" />
                    ) : (
                        <BsMoon class="theme-button-icon" />
                    )}
                </button>
            </div>
        </header>
    );
}

export default Header;
