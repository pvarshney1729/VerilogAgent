module TopModule (
    input logic [15:0] scancode,
    output logic left,
    output logic down,
    output logic right,
    output logic up
);

always @(*) begin
    // Default output states
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    // Process scancode to determine which arrow key is pressed
    case (scancode)
        16'hE06B: left = 1'b1;    // Left arrow key pressed
        16'hE072: down = 1'b1;    // Down arrow key pressed
        16'hE074: right = 1'b1;   // Right arrow key pressed
        16'hE075: up = 1'b1;      // Up arrow key pressed
        default: begin
            // All outputs remain low, indicating no arrow key pressed
        end
    endcase
end

endmodule