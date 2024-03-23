import "../assets/scss/download_modal.scss";
import { Show } from "solid-js/web";

/**
 * Download modal.
 * @function DownloadModal
 * @returns {JSX.Element}
 */
function DownloadModal(props) {
    const [showDownloadModal, setShowDownloadModal] = props.showDownloadModal;

    function closeModal() {
        setShowDownloadModal(false);
    }

    return (
        <Show when={showDownloadModal()}>
            <div class="download-modal-background" onClick={closeModal}>
                <div class="download-modal" onClick={(e) => e.stopPropagation()}>
                    <h2>Download Flow Diagram</h2>
                    <label for="format">Choose Format:</label>
                    <select name="format" id="format">
                        <option value="png">PNG</option>
                        <option value="svg">SVG</option>
                        <option value="jpg">JPG</option>
                        <option value="pdf">PDF</option>
                        <option value="html">HTML</option>
                    </select>
                    <button
                        class="download-modal-button"
                        onClick={closeModal}
                        type="button"
                        title="Download"
                    >
                        Download
                    </button>
                </div>
            </div>
        </Show>
    );
}

export default DownloadModal;
