import { useState, useEffect } from "react";
import "../assets/css/header.css";

import Sun from "../assets/svgs/sun.svg?react";
import Moon from "../assets/svgs/moon.svg?react";
import Bars from "../assets/svgs/bars.svg?react";
import Logo from "../assets/svgs/logo.svg?react";

const GithubButton: React.FunctionComponent = () => {
  return (
    <a
      className="github-button"
      href="https://github.com/cecoeco/PRISMA.jl"
      target="_blank"
    >
      <img
        className="github-image"
        src="https://img.shields.io/github/stars/cecoeco/PRISMA.jl?style=social"
        alt="GitHub"
      />
    </a>
  );
};

const Navigation: React.FunctionComponent<{ isMobileMenuOpen: boolean }> = ({
  isMobileMenuOpen,
}) => {
  const [activeLink, setActiveLink] = useState("");

  useEffect(() => {
    const updateActiveLink = () => {
      setActiveLink(window.location.hash);
    };

    window.addEventListener("hashchange", updateActiveLink);
    updateActiveLink();

    return () => window.removeEventListener("hashchange", updateActiveLink);
  }, []);

  return (
    <nav className="navigation">
      <h1 className="header-title"><Logo className="header-logo" />PRISMA.jl</h1>
      <div className={`nav-links ${isMobileMenuOpen ? "mobile-open" : ""}`}>
        <a
          href="#checklist"
          title="Generate the PRISMA checklist"
          className={`nav-link ${activeLink === "#checklist" ? "active" : ""}`}
          aria-label="checklist section"
        >
          Checklist
        </a>
        <a
          href="#flow_diagram"
          title="Generate the PRISMA flow diagram"
          className={`nav-link ${activeLink === "#flow_diagram" ? "active" : ""}`}
          aria-label="flow diagram section"
        >
          Flow Diagram
        </a>
        <GithubButton />
      </div>
    </nav>
  );
};

const ThemeButton: React.FunctionComponent = () => {
  const [isLightTheme, setIsLightTheme] = useState(true);

  const toggleTheme = () => {
    setIsLightTheme((prevTheme) => {
      const newTheme = !prevTheme ? "light" : "dark";
      document.documentElement.setAttribute("data-theme", newTheme);
      return !prevTheme;
    });
  };

  useEffect(() => {
    const prefersDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;
    setIsLightTheme(!prefersDarkMode);
    const theme = prefersDarkMode ? "dark" : "light";
    document.documentElement.setAttribute("data-theme", theme);
  }, []);

  return (
    <button
      className="theme-button"
      onClick={toggleTheme}
      title="Toggle theme"
      role="switch"
      aria-checked={isLightTheme}
    >
      {isLightTheme ? (
        <Sun className="theme-button-icon" />
      ) : (
        <Moon className="theme-button-icon" />
      )}
    </button>
  );
};

export default function Header(): React.JSX.Element {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 0);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen((prevState) => !prevState);
  };

  return (
    <header className={isScrolled ? "header scrolled" : "header"}>
      <Navigation isMobileMenuOpen={isMobileMenuOpen} />
      <ThemeButton />
      <button className="menu-button" onClick={toggleMobileMenu} aria-label="Toggle menu">
        <Bars className="menu-button-icon" />
      </button>
    </header>
  );
}
