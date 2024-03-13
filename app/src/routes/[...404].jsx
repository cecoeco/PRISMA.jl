import { HttpStatusCode } from "@solidjs/start";
import "../assets/scss/notfound.scss";
/**
 * Represents a component rendered when a page is not found (HTTP 404 Error).
 *
 * This component displays a message indicating that the requested page
 * could not be found.
 *
 * @return {JSX.Element} The rendered NotFound component
 */
function NotFound() {
    return (
        <div class="notfound">
            <HttpStatusCode code={404} />
            <h1 class="title">404 Error</h1>
            <p class="message">Page not found</p>
        </div>
    );
}

export default NotFound;
