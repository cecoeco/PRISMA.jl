import "../assets/scss/citation.scss";
/**
 * Renders the Citation component, which displays citations in various formats.
 *
 * This component renders different citation formats, such as BibTeX, AMA,
 * APA, Chicago, IEEE, and MLA, along with copy buttons to copy the citation
 * text to the clipboard.
 *
 * @returns {JSX.Element} The rendered Citation component.
 */
function Citation() {
    /**
     * Copies the text content of the element with the given id to the clipboard.
     *
     * @param {string} id - The id of the element containing the text to be copied.
     * @param {HTMLElement} button - The button triggering the copy action.
     */
    const copyToClipboard = (id, button) => {
        const codeElement = document.getElementById(id);
        const text = codeElement.innerText;
        navigator.clipboard
            .writeText(text)
            .then(() => {
                console.log("Text copied to clipboard");
                button.innerHTML = '<img draggable="false" class="check-button-icon" src="src/assets/svg/check.svg" alt="check" />';
                button.classList.remove("copy-button");
                button.classList.add("check-button");
                setTimeout(() => {
                    button.innerHTML = '<img draggable="false" class="copy-button-icon" src="src/assets/svg/copy.svg" alt="copy" />';
                    button.classList.remove("check-button");
                    button.classList.add("copy-button");
                }, 1500);
            })
            .catch((error) => {
                console.error("Error copying text to clipboard:", error);
            });
    };

    return (
        <div class="citation">
            <h3 class="citation-title">BibTeX</h3>
            <div class="code-container">
                <pre
                    id="bibtex"
                    class="code language-bib"
                >
                    <span class="entry-type">@software</span>
                    <span class="bracket">{'{'}</span>
                    <span class="cite-key">PRISMA.jl</span>
                    <span class="comma">,</span>
                    <br />
                    <span>{'  '}</span>
                    <span class="field">author</span>
                    <span>{'      '}</span>
                    <span class="equal"> = </span>
                    <span class="bracket">{'{'}</span>
                    <span class="field-value">Ceco E. Maples</span>
                    <span class="bracket">{'}'}</span>
                    <span class="comma">,</span>
                    <br />
                    <span>{'  '}</span>
                    <span class="field">title</span>
                    <span>{'       '}</span>
                    <span class="equal"> = </span>
                    <span class="bracket">{'{'}</span>
                    <span class="field-value">PRISMA.jl</span>
                    <span class="bracket">{'}'}</span>
                    <span class="comma">,</span>
                    <br />
                    <span>{'  '}</span>
                    <span class="field">howpublished</span
                    ><span class="equal"> = </span>
                    <span class="bracket">{'{'}</span>
                    <span class="field-value">\url</span>
                    <span class="bracket">{'{'}</span>
                    <span class="url">https://github.com/cecoeco/PRISMA.jl</span>
                    <span class="bracket">{'}'}</span>
                    <span class="bracket">{'}'}</span>
                    <span class="comma">,</span>
                    <br />
                    <span>{'  '}</span>
                    <span class="field">year</span>
                    <span>{'        '}</span>
                    <span class="equal"> = </span>
                    <span class="bracket">{'{'}</span>
                    <span class="field-value">2024</span>
                    <span class="bracket">{'}'}</span>
                    <br />
                    <span class="bracket">{'}'}</span>
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("bibtex", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>

            <h3 class="citation-title">
                American Medical Association (AMA) 11th edition
            </h3>
            <div class="code-container">
                <pre
                    id="ama"
                    class="code"
                >
                    [1] Ceco E. Maples. PRISMA.jl. 2024. Available from:
                    https://github.com/cecoeco/PRISMA.jl
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("ama", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>

            <h3 class="citation-title">
                American Psychological Association (APA) 7th edition
            </h3>
            <div class="code-container">
                <pre
                    id="apa"
                    class="code"
                >
                    Maples, C. E. (2024). PRISMA.jl. [Software]. Retrieved from
                    https://github.com/cecoeco/PRISMA.jl
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("apa", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>

            <h3 class="citation-title">
                Chicago Manual of Style 17th edition
            </h3>
            <div class="code-container">
                <pre
                    id="chicago"
                    class="code"
                >
                    Maples, Ceco E. 2024. PRISMA.jl.
                    https://github.com/cecoeco/PRISMA.jl
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("chicago", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>

            <h3 class="citation-title">
                Institute of Electrical and Electronics Engineers (IEEE)
            </h3>
            <div class="code-container">
                <pre
                    id="ieee"
                    class="code"
                >
                    C. E. Maples, “PRISMA.jl,” 2024. [Online]. Available:
                    https://github.com/cecoeco/PRISMA.jl
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("ieee", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>

            <h3 class="citation-title">
                Modern Language Association (MLA) 9th edition
            </h3>
            <div class="code-container">
                <pre
                    id="mla"
                    class="code"
                >
                    Maples, Ceco E. PRISMA.jl. 2024. Web.
                    https://github.com/cecoeco/PRISMA.jl
                </pre>
                <button
                    class="copy-button"
                    onClick={(event) => copyToClipboard("mla", event.currentTarget)}
                >
                    <img
                        draggable="false"
                        class="copy-button-icon"
                        src="src/assets/svg/copy.svg"
                        alt="copy"
                    />
                </button>
            </div>
        </div>
    );
}

export default Citation;