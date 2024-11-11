import "../assets/scss/home.scss";

const Home: React.FC = () => {
  async function downloadChecklistTemplate() {
    try {
      const response = await fetch("/api/checklist/template", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });

      if (response.ok) {
        const data = await response.json();
        const csvContent = data.checklist_template;

        const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
        const url = URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.setAttribute("href", url);
        link.setAttribute("download", "PRISMA_checklist.csv");
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      } else {
        console.error("Failed to download the checklist template.");
      }
    } catch (error) {
      console.error("Error downloading checklist template: ", error);
    }
  }

  return (
    <main className="home-page">
      <section className="intro">
        <h1>
          Welcome to{" "}
          <a href="https://cecoeco.github.io/PRISMA.jl/dev/" target="_blank">
            PRISMA.jl
          </a>
        </h1>
        <br />
        <p>
          PRISMA.jl is a package and web app written in the scientific programming
          language,{" "}
          <a href="https://julialang.org/" target="_blank">
            Julia.
          </a>{" "}
          It simplifies the creation of PRISMA checklists and flow diagrams by leveraging
          advanced data visualizations and natural language processing. Simply upload your
          document, and PRISMA.jl will automatically generate the necessary PRISMA
          documentation for your systematic review or meta-analysis.
        </p>
      </section>

      <section className="about-prisma">
        <h2>
          The PRISMA (Preferred Reporting Items for Systematic Reviews and Meta-Analyses)
          2020 Statement
        </h2>
        <br />
        <p>
          The PRISMA 2020 statement is an update to the original 2009 guideline,
          reflecting the latest advancements in systematic review methodology. It includes
          a comprehensive 27-item checklist to help authors clearly report their reviews,
          covering everything from the rationale to the methods and results.
        </p>
        <br />
        <p>
          Additionally, the guideline introduces new flow diagrams for both original and
          updated reviews, providing expanded reporting recommendations. The PRISMA 2020
          statement is widely supported and freely accessible on numerous leading medical
          and scientific journal websites.
        </p>
      </section>

      <section className="features">
        <h2>Features</h2>
        <p>
          <strong>Checklist:</strong> Upload a PDF and generate a PRISMA checklist based
          on its content.
        </p>
        <p>
          <strong>Checklist Template:</strong> Download a copy of the PRISMA checklist as
          a CSV:{" "}
          <button onMouseDown={downloadChecklistTemplate} className="download-button">
            Download Checklist
          </button>
        </p>
        <p>
          <strong>Flow Diagram:</strong> Input the results from a study and generate a
          PRISMA flow diagram.
        </p>
      </section>

      <section className="resources">
        <h2>PRISMA 2020 Resources</h2>
        <br />
        <p>
          Access the full PRISMA 2020 statement, including the 27-item checklist, abstract
          checklist, and flow diagrams, on the following websites:
        </p>
        <ul>
          <li>
            <a href="https://www.bmj.com/content/372/bmj.n71" target="_blank">
              BMJ
            </a>
          </li>
          <li>
            <a
              href="https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1003583"
              target="_blank"
            >
              PLOS Medicine
            </a>
          </li>
          <li>
            <a
              href="https://www.jclinepi.com/article/S0895-4356(21)00051-0/fulltext"
              target="_blank"
            >
              Journal of Clinical Epidemiology
            </a>
          </li>
          <li>
            <a href="https://www.prisma-statement.org/" target="_blank">
              PRISMA website
            </a>
          </li>
        </ul>
      </section>

      <section className="navigation">
        <h2>Get Started</h2>
        <div className="nav-buttons">
          <a href="/checklist" className="nav-button">
            Generate PRISMA Checklist
          </a>
          <a href="/flow_diagram" className="nav-button">
            Create PRISMA Flow Diagram
          </a>
        </div>
      </section>
    </main>
  );
};

export default Home;
