import { exec } from 'child_process';

function GET() {
    try {
        exec('julia src/scripts/flow-diagram/dataframe.jl', (error, stdout, stderr) => {
            if (error) {
                console.error('Error running Julia script:', error);
                return 'Error running Julia script';
            }
            if (stderr) {
                console.error('Julia script stderr:', stderr);
            }
            console.log('Julia script stdout:', stdout);
            return stdout;
        });
    } catch (error) {
        console.error('Error sending dataframe file:', error);
        return 'Error sending dataframe file';
    }
}

export default GET;