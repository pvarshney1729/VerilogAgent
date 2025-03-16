module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);
    logic [1:0] count; // 2-bit counter to count up to 4

    always @(posedge clk) begin
        if (reset) begin
            count <= 2'b00;     // Reset the counter
            shift_ena <= 1'b1;  // Assert shift_ena on reset
        end else if (count < 2'b11) begin
            count <= count + 1; // Increment counter
            shift_ena <= 1'b1;   // Keep shift_ena asserted
        end else begin
            shift_ena <= 1'b0;   // Deassert shift_ena after 4 cycles
        end
    end
endmodule