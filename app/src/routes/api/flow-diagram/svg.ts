import { spawn } from 'child_process';

export async function POST(
    spreadsheet: string,
    format_numbers: boolean,
    background_color: string,
    grayboxes: boolean,
    grayboxes_color: string,
    top_nodes: boolean,
    top_nodes_border: boolean,
    top_nodes_color: string,
    side_nodes: boolean,
    side_nodes_border: number,
    side_nodes_color: string,
    previous_studies: boolean,
    other_methods: boolean,
    node_border_width: Number,
    node_border_color: string,
    font: number,
    font_color: string,
    font_size: number,
    arrow_color: string,
    arrow_head: string,
    arrow_head_size: number,
    arrow_width: number
) {
    const process = spawn(
        'julia',
        [
            'src/scripts/svg.jl',
            spreadsheet,
            format_numbers.toString(),
            background_color,
            grayboxes.toString(),
            grayboxes_color,
            top_nodes.toString(),
            top_nodes_border.toString(),
            top_nodes_color,
            side_nodes.toString(),
            side_nodes_border.toString(),
            side_nodes_color,
            previous_studies.toString(),
            other_methods.toString(),
            node_border_width.toString(),
            node_border_color,
            font.toString(),
            font_color,
            font_size.toString(),
            arrow_color,
            arrow_head,
            arrow_head_size.toString(),
            arrow_width.toString()
        ]
    );

    let svgData = '';

    process.stdout.on('data', (data) => {
        svgData += data.toString();
    });

    process.on('close', (code) => {
        if (code === 0) {
            console.log('SVG data:', svgData);
        } else {
            console.error(`Julia process exited with code ${code}`);
        }
    });
}
