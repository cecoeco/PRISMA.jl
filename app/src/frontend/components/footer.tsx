import "../assets/scss/footer.scss";

const Footer: React.FC = () => {
  return (
    <footer className="footer">
      © {new Date().getFullYear()} PRISMA.jl Contributors
      <a href="https://opensource.org/license/MIT/" target="_blank">
        MIT License
      </a>
    </footer>
  );
};

export default Footer;
