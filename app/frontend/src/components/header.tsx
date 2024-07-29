import "../assets/css/header.css";

import { createSignal, createEffect, onCleanup, JSXElement } from "solid-js";
import { A } from "@solidjs/router";

import Logo from "../assets/svgs/logo.svg?component-solid";

import Gituhb from "../assets/svgs/github.svg?component-solid";

import Sun from "../assets/svgs/sun.svg?component-solid";
import Moon from "../assets/svgs/moon.svg?component-solid";

const Link = (props: { href: string; children: string }) => (
  <A
    class="nav-link"
    href={props.href}
    title={props.href}
    activeClass="nav-link-active"
    end
  >
    {props.children}
  </A>
);

export default function Header() {
  const [isLightTheme, setIsLightTheme] = createSignal(true);
  const [isScrolled, setIsScrolled] = createSignal(false);

  const toggleTheme = () => {
    setIsLightTheme(!isLightTheme());
    const theme = isLightTheme() ? "light" : "dark";
    document.documentElement.setAttribute("data-theme", theme);
  };

  createEffect(() => {
    const prefersDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;
    setIsLightTheme(!prefersDarkMode);
    const theme = prefersDarkMode ? "dark" : "light";
    document.documentElement.setAttribute("data-theme", theme);
  });

  createEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 0);
    };

    window.addEventListener("scroll", handleScroll);
    onCleanup(() => window.removeEventListener("scroll", handleScroll));
  });

  return (
    <header class={isScrolled() ? "header scrolled" : "header"}>
      <h1 class="header-title">
        <Logo class="header-logo" />
        PRISMA.jl
      </h1>
      <nav>
        <Link href="/">Home</Link>
        <Link href="/checklist">Checklist</Link>
        <Link href="/flow_diagram">Flow Diagram</Link>
        <a title="GitHub" href="https://github.com/cecoeco/PRISMA.jl" target="_blank" class="github-link">
          <Gituhb class="github-icon" />
        </a>
        <button
          class="theme-button"
          onClick={toggleTheme}
          title="Toggle theme"
          role="switch"
        >
          {isLightTheme() ? (
            <Sun class="theme-button-icon" />
          ) : (
            <Moon class="theme-button-icon" />
          )}
        </button>
      </nav>
    </header>
  );
}
