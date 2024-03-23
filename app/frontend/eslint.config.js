import js from "@eslint/js";
import solid from "eslint-plugin-solid/configs/recommended";

export default [
    js.configs.recommended, // replaces eslint:recommended
    solid,
];
