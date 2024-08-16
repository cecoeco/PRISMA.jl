import solidPlugin from "vite-plugin-solid";
import solidSvg from "vite-plugin-solid-svg";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [solidPlugin(), solidSvg()],
  build: {
    assetsDir: "",
  },
});
