import { Title } from "@solidjs/meta";

function Citation() {
    const bibContent: string = `
        @software{PRISMA.jl,
            author       = {Ceco E. Maples},
            title        = {PRISMA.jl},
            howpublished = {\\url{https://github.com/cecoeco/PRISMA.jl}},
            year         = {2024}
        }
    `;

    const enlContent: string = `
        %0 Software
        %A Ceco E. Maples
        %T PRISMA.jl
        %D 2024
        %R https://github.com/cecoeco/PRISMA.jl
    `;

    const risContent: string = `
        TY  - SOFTWARE
        AU  - Ceco E. Maples
        TI  - PRISMA.jl
        PY  - 2024
        UR  - https://github.com/cecoeco/PRISMA.jl
    `;

    const downloadFile = (content: string, type: string, extension: string) => {
        const blob = new Blob([content], { type });
        const blobUrl = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = blobUrl;
        a.download = `PRISMA_jl.${extension}`;
        a.click();
        URL.revokeObjectURL(blobUrl);
    };

    const downloadBib = () => {
        downloadFile(bibContent, 'text/plain', 'bib');
    };

    const downloadEnl = () => {
        downloadFile(enlContent, 'application/x-endnote-refer', 'enl');
    };

    const downloadRIS = () => {
        downloadFile(risContent, 'application/x-research-info-systems', 'ris');
    };

    return (
        <>
            <Title>Citation</Title>
            <main class="citation">
                <button onClick={downloadBib}>Download BibTeX</button>
                <button onClick={downloadEnl}>Download EndNote</button>
                <button onClick={downloadRIS}>Download RIS</button>
            </main>
        </>
    );
}

export default Citation;
