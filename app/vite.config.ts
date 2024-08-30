import solidPlugin from "vite-plugin-solid";
import solidSvg from "vite-plugin-solid-svg";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [solidPlugin(), solidSvg()],
  build: {
    outDir: "./src/build",
    emptyOutDir: true,
    rollupOptions: {
      input: "./src/solid/index.tsx",
      output: {
        entryFileNames: "[name].js",
        chunkFileNames: "[name].js",
        assetFileNames: "[name].[ext]",
      },
    },
    assetsDir: "",
  },
});
