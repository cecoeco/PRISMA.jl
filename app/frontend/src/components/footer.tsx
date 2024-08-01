import "../assets/css/footer.css";

const Footer = () => {
  return (
    <footer>
      © {new Date().getFullYear()} PRISMA.jl contributors
      <a href="https://opensource.org/license/MIT/" target="_blank">
        MIT License
      </a>
    </footer>
  );
}

export default Footer;