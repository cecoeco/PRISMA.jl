import { useState, useEffect } from "react";
import { NavLink } from "react-router-dom";

import "../assets/css/header.css";

import Logo from "../assets/svgs/logo.svg?react";
import Github from "../assets/svgs/github.svg?react";
import Sun from "../assets/svgs/sun.svg?react";
import Moon from "../assets/svgs/moon.svg?react";

const Header = () => {
  const [isLightTheme, setIsLightTheme] = useState(true);
  const [isScrolled, setIsScrolled] = useState(false);

  const toggleTheme = () => {
    setIsLightTheme(!isLightTheme);
    const theme = isLightTheme ? "light" : "dark";
    document.documentElement.setAttribute("data-theme", theme);
  };

  useEffect(() => {
    const prefersDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;
    setIsLightTheme(!prefersDarkMode);
    const theme = prefersDarkMode ? "dark" : "light";
    document.documentElement.setAttribute("data-theme", theme);
  }, []);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 0);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <header className={isScrolled ? "header scrolled" : "header"}>
      <h1 className="header-title">
        <Logo className="header-logo" />
        PRISMA.jl
      </h1>
      <nav>
        <NavLink
          to="/"
          className={({ isActive }) =>
            isActive ? "nav-link nav-link-active" : "nav-link"
          }
          end
        >
          Home
        </NavLink>
        <NavLink
          to="/checklist"
          className={({ isActive }) =>
            isActive ? "nav-link nav-link-active" : "nav-link"
          }
        >
          Checklist
        </NavLink>
        <NavLink
          to="/flow_diagram"
          className={({ isActive }) =>
            isActive ? "nav-link nav-link-active" : "nav-link"
          }
        >
          Flow Diagram
        </NavLink>
        <a
          title="GitHub"
          href="https://github.com/cecoeco/PRISMA.jl"
          target="_blank"
          rel="noopener noreferrer"
          className="github-link"
        >
          <Github className="github-icon" />
        </a>
        <button
          className="theme-button"
          onClick={toggleTheme}
          title="Toggle theme"
          role="switch"
        >
          {isLightTheme ? (
            <Sun className="theme-button-icon" />
          ) : (
            <Moon className="theme-button-icon" />
          )}
        </button>
      </nav>
    </header>
  );
};

export default Header;
