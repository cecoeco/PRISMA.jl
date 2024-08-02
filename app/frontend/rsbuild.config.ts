import { defineConfig } from "@rsbuild/core";
import { pluginReact } from "@rsbuild/plugin-react";
import { pluginSvgr } from "@rsbuild/plugin-svgr";

export default defineConfig({
  plugins: [pluginReact(), pluginSvgr()],
  source: {
    entry: { index: "./src/app.tsx" },
  },
  html: {
    title: "PRISMA.jl",
    favicon: "./src/assets/favicon.ico",
    meta: {
      charset: "utf-8",
      viewport: "width=device-width, initial-scale=1",
      description: "checklists and flow diagrams based on the 2020 PRISMA statement",
      keywords: "PRISMA, checklists, flow diagrams",
      author: "Ceco Elijah Maples, PRISMA.jl contributors",
    },
  },
});
