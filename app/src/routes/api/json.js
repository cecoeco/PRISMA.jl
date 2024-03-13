import { exec } from "node:child_process";

export async function GET() {
    return new Promise((resolve, reject) => {
        exec("julia jl/json.jl", (error, stdout, stderr) => {
            if (error) {
                console.error("Error running Julia script:", error);
                reject("Error running Julia script");
            } else if (stderr) {
                console.error("Julia script stderr:", stderr);
                resolve(stderr);
            } else {
                console.log("Julia script stdout:", stdout);
                resolve(stdout);
            }
        });
    });
}
