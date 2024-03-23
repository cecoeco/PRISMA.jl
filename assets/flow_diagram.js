function createBox({
    display = "inline",
    x,
    y,
    width,
    height,
    boxColor = "white",
    border,
    borderColor,
    borderWidth
}) {
    const box = document.createElementNS("http://www.w3.org/2000/svg", "polygon");
    box.setAttribute("display", display);
    box.setAttribute(
        "points",
        `${x},${y} ${x + width},${y} ${x + width},${y + height} ${x},${y + height}`
    );
    box.setAttribute("fill", boxColor);
    if (border === true) {
        box.setAttribute("stroke", borderColor);
        box.setAttribute("stroke-width", borderWidth);
    }
    return box;
}

function createText({
    x,
    y,
    fontFamily,
    fontSize,
    fontColor,
    fontWeight = "normal",
    rotation = 0,
    content,
    url,
    isInteractive,
}) {
    const text = document.createElementNS("http://www.w3.org/2000/svg", "text");
    text.setAttribute("x", x);
    text.setAttribute("y", y);
    text.setAttribute("font-family", fontFamily);
    text.setAttribute("font-size", fontSize);
    text.setAttribute("fill", fontColor);
    text.setAttribute("font-weight", fontWeight);
    text.setAttribute("transform", `rotate(${rotation})`);
    text.setAttribute("text-anchor", "middle");
    text.setAttribute("dominant-baseline", "middle");

    if (isInteractive === true) {
        const link = document.createElementNS("http://www.w3.org/2000/svg", "a");
        link.setAttributeNS("http://www.w3.org/1999/xlink", "href", url);
        link.setAttribute("title", url);
        link.style.cursor = "pointer";
        link.appendChild(text);
        text.appendChild(document.createTextNode(content));
        link.addEventListener("mouseenter", function () {
            text.style.textDecoration = "underline";
        });
        link.addEventListener("mouseleave", function () {
            text.style.textDecoration = "none";
        });

        return link;
    } else {
        text.textContent = content;
        return text;
    }
}

function createArrow({
    display = "inline",
    startX,
    startY,
    endX,
    endY,
    arrowColor,
    arrowWidth,
}) {
    const arrow = document.createElementNS("http://www.w3.org/2000/svg", "path");
    arrow.setAttribute("display", display);
    arrow.setAttribute("stroke", arrowColor);
    arrow.setAttribute("stroke-width", arrowWidth);
    arrow.setAttribute("d", `M ${startX} ${startY} L ${endX} ${endY}`);
    return arrow;
}

function createGroup(contentArray) {
    const group = document.createElementNS("http://www.w3.org/2000/svg", "g");

    contentArray.forEach(({ element, texts }) => {
        group.appendChild(element);
        texts.forEach((text) => {
            group.appendChild(text);
        });
    });

    return group;
}

function flow_diagram(
    data,
    format_numbers = true,
    interactive = true,
    background_color = "#ffffff",
    grayboxes = true,
    grayboxes_color = "#f0f0f0",
    top_boxes = true,
    top_boxes_border = false,
    top_boxes_color = "#ffc000",
    side_boxes = true,
    side_boxes_border = false,
    side_boxes_color = "#95cbff",
    previous_studies = true,
    other_methods = true,
    box_border_width = 1,
    box_border_color = "#000000",
    font = "Helvetica",
    font_color = "black",
    font_size = 10,
    font_weight = "bold",
    arrow_color = "black",
    arrow_width = 1
) {
    if (format_numbers == true) {
        data;
    };

    const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    svg.setAttribute("background-color", background_color);
    svg.setAttribute("width", "100%");
    svg.setAttribute("height", "100%");
    document.body.appendChild(svg);

    const box_01 = createGroup([
        {
            element: createBox({
                display:
                    previous_studies == true
                        ? top_boxes == true
                            ? "inline"
                            : "none"
                        : "none",
                x: 0,
                y: 0,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : top_boxes_color,
                border: grayboxes == true ? false : top_boxes_border,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    x: 125,
                    y: 30,
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    content: "Previous studies",
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_02 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 60,
                width: 250,
                height: 60,
                boxColor: top_boxes_color,
                border: top_boxes_border == true ? true : false,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_03 = createGroup([
        {
            element: createBox({
                display:
                    other_methods == true
                        ? top_boxes == true
                            ? "inline"
                            : "none"
                        : "none",
                x: 250,
                y: 0,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : top_boxes_color,
                border: grayboxes == true ? false : top_boxes_border,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_04 = createGroup([
        {
            element: createBox({
                display: side_boxes == true ? "inline" : "none",
                x: 0,
                y: 120,
                width: 250,
                height: 60,
                boxColor: side_boxes_color,
                border: side_boxes_border == true ? true : false,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                    rotation: -90,
                }),
            ],
        },
    ]);

    const box_05 = createGroup([
        {
            element: createBox({
                display: side_boxes == true ? "inline" : "none",
                x: 250,
                y: 120,
                width: 250,
                height: 60,
                boxColor: side_boxes_color,
                border: side_boxes_border == true ? true : false,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                    rotation: -90,
                }),
            ],
        },
    ]);

    const box_06 = createGroup([
        {
            element: createBox({
                display: side_boxes == true ? "inline" : "none",
                x: 500,
                y: 120,
                width: 250,
                height: 60,
                boxColor: side_boxes_color,
                border: side_boxes_border == true ? true : false,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                    rotation: -90,
                }),
            ],
        },
    ]);

    const box_07 = createGroup([
        {
            element: createBox({
                display: previous_studies == true ? "inline" : "none",
                x: 250,
                y: 180,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_08 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 240,
                width: 250,
                height: 60,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_09 = createGroup([
        {
            element: createBox({
                x: 250,
                y: 240,
                width: 250,
                height: 60,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_10 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 300,
                width: 250,
                height: 60,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_11 = createGroup([
        {
            element: createBox({
                x: 250,
                y: 300,
                width: 250,
                height: 60,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_12 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 360,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_13 = createGroup([
        {
            element: createBox({
                x: 250,
                y: 360,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_14 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 420,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_15 = createGroup([
        {
            element: createBox({
                x: 250,
                y: 420,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_16 = createGroup([
        {
            element: createBox({
                x: 0,
                y: 480,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_17 = createGroup([
        {
            element: createBox({
                x: 250,
                y: 480,
                width: 250,
                height: 60,
                border: true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_18 = createGroup([
        {
            element: createBox({
                display: other_methods == true ? "inline" : "none",
                x: 0,
                y: 540,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_19 = createGroup([
        {
            element: createBox({
                display: other_methods == true ? "inline" : "none",
                x: 250,
                y: 540,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_20 = createGroup([
        {
            element: createBox({
                display: other_methods == true ? "inline" : "none",
                x: 0,
                y: 600,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_21 = createGroup([
        {
            element: createBox({
                display: other_methods == true ? "inline" : "none",
                x: 250,
                y: 600,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_22 = createGroup([
        {
            element: createBox({
                display: other_methods == true ? "inline" : "none",
                x: 0,
                y: 660,
                width: 250,
                height: 60,
                boxColor: grayboxes == true ? grayboxes_color : "white",
                border: grayboxes == true ? false : true,
                borderColor: box_border_color,
                borderWidth: box_border_width,
            }),
            texts: [
                createText({
                    fontFamily: font,
                    fontSize: font_size,
                    fontColor: font_color,
                    fontWeight: font_weight,
                    isInteractive: interactive,
                }),
            ],
        },
    ]);

    const box_07_to_box_17 = createArrow({
        display: previous_studies == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_08_to_box_09 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_08_to_box_10 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_10_to_box_11 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_10_to_box_12 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_12_to_box_13 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_12_to_box_14 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_14_to_box_15 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_14_to_box_16 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_16_to_box_17 = createArrow({
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_18_to_box_19 = createArrow({
        display: other_methods == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_19_to_box_20 = createArrow({
        display: other_methods == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_19_to_box_21 = createArrow({
        display: other_methods == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_21_to_box_16 = createArrow({
        display: other_methods == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    const box_21_to_box_22 = createArrow({
        display: other_methods == true ? "inline" : "none",
        arrowColor: arrow_color,
        arrowWidth: arrow_width,
    });

    svg.appendChild(box_01);
    svg.appendChild(box_02);
    svg.appendChild(box_03);
    svg.appendChild(box_04);
    svg.appendChild(box_05);
    svg.appendChild(box_06);
    svg.appendChild(box_07);
    svg.appendChild(box_08);
    svg.appendChild(box_09);
    svg.appendChild(box_10);
    svg.appendChild(box_11);
    svg.appendChild(box_12);
    svg.appendChild(box_13);
    svg.appendChild(box_14);
    svg.appendChild(box_15);
    svg.appendChild(box_16);
    svg.appendChild(box_17);
    svg.appendChild(box_18);
    svg.appendChild(box_19);
    svg.appendChild(box_20);
    svg.appendChild(box_21);
    svg.appendChild(box_22);

    svg.appendChild(box_07_to_box_17);
    svg.appendChild(box_08_to_box_09);
    svg.appendChild(box_08_to_box_10);
    svg.appendChild(box_10_to_box_11);
    svg.appendChild(box_10_to_box_12);
    svg.appendChild(box_12_to_box_13);
    svg.appendChild(box_12_to_box_14);
    svg.appendChild(box_14_to_box_15);
    svg.appendChild(box_14_to_box_16);
    svg.appendChild(box_16_to_box_17);
    svg.appendChild(box_18_to_box_19);
    svg.appendChild(box_19_to_box_20);
    svg.appendChild(box_19_to_box_21);
    svg.appendChild(box_21_to_box_16);
    svg.appendChild(box_21_to_box_22);
}

export default flow_diagram;
