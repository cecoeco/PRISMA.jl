import "../assets/scss/Footer.scss";

/**
 * Render the footer component.
 *
 * @return {JSX.Element} The rendered footer component
 */
function Footer() {
    return (
        <footer class="footer">
            <small class="footer-text-container">
                <small class="footer-text">
                    © 2024 Ceco Elijah Maples. All rights reserved.
                </small>
                <a
                    class="footer-text footer-link"
                    href="https://opensource.org/license/MIT/"
                >
                    MIT License.
                </a>
            </small>
        </footer>
    );
}

export default Footer;
