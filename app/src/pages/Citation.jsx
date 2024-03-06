import "../assets/scss/Citation.scss";

function Citation() {
    const bibContent = `@software{PRISMA.jl,
    author       = {Ceco E. Maples},
    title        = {PRISMA.jl},
    howpublished = {\\url{https://github.com/cecoeco/PRISMA.jl}},
    year         = {2024}\n}`;

    const downloadBib = () => {
        const blob = new Blob([bibContent], { type: "text/plain" });
        const a = document.createElement("a");
        a.href = URL.createObjectURL(blob);
        a.download = "PRISMA_jl.bib";
        a.click();
        URL.revokeObjectURL(a.href);
    };

    return (
        <>
            <main class="citation">
                <h3>BibTeX</h3>
                <div class="code-container">
                    <pre class="code">{bibContent}</pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>
                <button onClick={downloadBib}>Download BibTeX</button>

                <h3>American Medical Association (AMA) 11th edition</h3>
                <div class="code-container">
                    <pre class="code">
                        [1] Ceco E. Maples. PRISMA.jl. 2024. Available from:
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>

                <h3>American Psychological Association (APA) 7th edition</h3>
                <div class="code-container">
                    <pre class="code">
                        Maples, C. E. (2024). PRISMA.jl. [Software]. Retrieved from
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>

                <h3>Chicago Manual of Style 17th edition</h3>
                <div class="code-container">
                    <pre class="code">
                        Maples, Ceco E. 2024. PRISMA.jl.
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>

                <h3>Institute of Electrical and Electronics Engineers (IEEE)</h3>
                <div class="code-container">
                    <pre class="code">
                        C. E. Maples, “PRISMA.jl,” 2024. [Online]. Available:
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>

                <h3>Modern Language Association (MLA) 9th edition</h3>
                <div class="code-container">
                    <pre class="code">
                        Maples, Ceco E. PRISMA.jl. 2024. Web.
                        https://github.com/cecoeco/PRISMA.jl
                    </pre>
                    <button class="copy-button">
                        <img class="copy-button-icon" src="/svg/copy.svg" alt="copy" />
                    </button>
                </div>
            </main>
        </>
    );
}

export default Citation;