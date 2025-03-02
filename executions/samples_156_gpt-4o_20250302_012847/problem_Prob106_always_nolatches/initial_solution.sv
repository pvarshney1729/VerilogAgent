module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] scancode,
    output logic up,
    output logic down,
    output logic left,
    output logic right
);

    // Combinational logic to decode scancode to arrow key outputs
    always @(*) begin
        // Default all outputs to zero
        up = 1'b0;
        down = 1'b0;
        left = 1'b0;
        right = 1'b0;

        // Decode scancode
        case (scancode)
            8'h75: up = 1'b1;    // Example scancode for up arrow
            8'h72: down = 1'b1;  // Example scancode for down arrow
            8'h6B: left = 1'b1;  // Example scancode for left arrow
            8'h74: right = 1'b1; // Example scancode for right arrow
            default: ;           // No action for other scancodes
        endcase
    end

    // Synchronous reset logic
    always_ff @(posedge clk) begin
        if (reset) begin
            up <= 1'b0;
            down <= 1'b0;
            left <= 1'b0;
            right <= 1'b0;
        end
    end

endmodule