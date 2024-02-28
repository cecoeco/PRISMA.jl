import { createHandler, StartServer } from "@solidjs/start/server";

export default createHandler(() => (
    <StartServer
        document={({ assets, children, scripts }) => (
            <html lang="en">
                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1" />
                    <title>PRISMA.jl</title>
                    <meta name="description" content="Generate checklists and flow diagrams for systematic reviews and meta-analyses." />
                    <meta name="author" content="Ceco E Maples" />
                    <meta name="keywords" content="PRISMA, systematic review, meta-analysis, checklist, flow diagram" />
                    <link rel="icon" type="image/svg+xml" href="../public/svg/favicon.svg" />
                    {assets}
                </head>
                <body id="app">
                    {children}
                    {scripts}
                </body>
            </html>
        )}
    />
));
