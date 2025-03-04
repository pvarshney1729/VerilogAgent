module TopModule (
    input logic [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

    always @(*) begin
        // Default all outputs to low
        left = 1'b0;
        down = 1'b0;
        right = 1'b0;
        up = 1'b0;

        // Decode scancode
        case (scancode)
            16'he06b: left = 1'b1;  // Left arrow key
            16'he072: down = 1'b1;  // Down arrow key
            16'he074: right = 1'b1; // Right arrow key
            16'he075: up = 1'b1;    // Up arrow key
            default: ; // Do nothing, all outputs remain low
        endcase
    end

endmodule