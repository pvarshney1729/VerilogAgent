module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

logic [1:0] cycle_count; // 2 bits to count 0 to 3

always @(posedge clk) begin
    if (reset) begin
        cycle_count <= 2'b00; // Reset the counter
        shift_ena <= 1'b1;    // Assert shift_ena on reset
    end else if (cycle_count < 2'b11) begin
        cycle_count <= cycle_count + 1'b1; // Increment counter
        shift_ena <= 1'b1;    // Keep shift_ena asserted
    end else begin
        shift_ena <= 1'b0;    // Deassert shift_ena after 4 cycles
    end
end

endmodule