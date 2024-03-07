import "../assets/scss/Citation.scss";

function Citation() {
    const bibContent = `@software{PRISMA.jl,
    author       = {Ceco E. Maples},
    title        = {PRISMA.jl},
    howpublished = {\\url{https://github.com/cecoeco/PRISMA.jl}},
    year         = {2024}\n}`;

    return (
        <>
            <div class="citation">
                <h3 class="citation-title">BibTeX</h3>
                <div class="code-container">
                    <pre class="code">{bibContent}</pre>
                        <button
                            class="copy-button"
                        >
                            <img
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
                    <pre class="code">
                        [1] Ceco E. Maples. PRISMA.jl. 2024. Available from:
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img
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
                    <pre class="code">
                        Maples, C. E. (2024). PRISMA.jl. [Software]. Retrieved from
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img
                            class="copy-button-icon"
                            src="src/assets/svg/copy.svg"
                            alt="copy"
                        />
                    </button>
                </div>

                <h3 class="citation-title">Chicago Manual of Style 17th edition</h3>
                <div class="code-container">
                    <pre class="code">
                        Maples, Ceco E. 2024. PRISMA.jl.
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img
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
                    <pre class="code">
                        C. E. Maples, “PRISMA.jl,” 2024. [Online]. Available:
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img
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
                    <pre class="code">
                        Maples, Ceco E. PRISMA.jl. 2024. Web.
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img
                            class="copy-button-icon"
                            src="src/assets/svg/copy.svg"
                            alt="copy"
                        />
                    </button>
                </div>
            </div>
        </>
    );
}

export default Citation;