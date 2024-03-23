import "../assets/scss/notfound.scss";
/**
 * Represents a component rendered when a page is not found (HTTP 404 Error).
 *
 * This component displays a message indicating that the requested page
 * could not be found.
 * @function NotFound
 * @return {JSX.Element} The rendered NotFound component
 */
function NotFound() {
    return (
        <div class="notfound">
            <p class="notfound-message">404 Error</p>
            <p class="notfound-message">Page not found</p>
        </div>
    );
}

export default NotFound;
