module TopModule (
    input logic clk,            // Clock input, 1-bit
    input logic reset,          // Active high synchronous reset, 1-bit
    output logic shift_ena      // Shift enable output, 1-bit
);

    logic [1:0] count;         // Counter for shift enable duration

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b1;  // Assert shift_ena on reset
            count <= 2'b00;     // Initialize counter
        end else if (count < 2'b11) begin
            count <= count + 1; // Increment counter
            shift_ena <= 1'b1;   // Keep shift_ena asserted
        end else begin
            shift_ena <= 1'b0;   // Deassert shift_ena after 4 cycles
        end
    end

endmodule