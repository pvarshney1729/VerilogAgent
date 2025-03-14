module TopModule(
    input logic clk,               // Clock input for synchronous operation
    input logic reset_n,           // Active-low asynchronous reset
    input logic [15:0] scancode,   // 16-bit input representing PS/2 keyboard scan code (unsigned)
    output logic left,              // Output signal for left arrow key (active high)
    output logic down,              // Output signal for down arrow key (active high)
    output logic right,             // Output signal for right arrow key (active high)
    output logic up                 // Output signal for up arrow key (active high)
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Asynchronous reset state
        left <= 1'b0; 
        down <= 1'b0; 
        right <= 1'b0; 
        up <= 1'b0; 
    end else begin
        // Default output states
        left <= 1'b0; 
        down <= 1'b0; 
        right <= 1'b0; 
        up <= 1'b0; 

        // Process scancode to determine the arrow key pressed
        case (scancode)
            16'hE06B: left <= 1'b1;   // Left arrow key pressed
            16'hE072: down <= 1'b1;   // Down arrow key pressed
            16'hE074: right <= 1'b1;  // Right arrow key pressed
            16'hE075: up <= 1'b1;     // Up arrow key pressed
            default: begin
                // Explicitly state that all outputs remain low for invalid scancodes
                left <= 1'b0; 
                down <= 1'b0; 
                right <= 1'b0; 
                up <= 1'b0; 
            end
        endcase
    end
end

endmodule