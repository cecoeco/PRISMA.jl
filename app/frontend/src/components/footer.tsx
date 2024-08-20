import "../assets/css/footer.css";

export default function Footer() {
  return (
    <footer>
      © {new Date().getFullYear()} PRISMA.jl contributors
      <a href="https://opensource.org/license/MIT/" target="_blank">
        MIT License
      </a>
    </footer>
  );
}
