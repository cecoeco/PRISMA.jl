import { spawn } from 'child_process';

export async function POST(filePath: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
        const process = spawn('julia', ['src/scripts/svg.jl', filePath]);
        let svgData = '';
        process.stdout.on('data', (data) => {
            svgData += data.toString();
        });
        process.stderr.on('data', (data) => {
            console.error('Error executing Julia script:', data.toString());
            reject(new Error(data.toString()));
        });
        process.on('close', (code) => {
            if (code === 0) {
                resolve(svgData);
            } else {
                reject(new Error(`Julia script exited with code ${code}`));
            }
        });
        process.on('error', (error) => {
            console.error('Error executing Julia script:', error);
            reject(error);
        });
    });
}
