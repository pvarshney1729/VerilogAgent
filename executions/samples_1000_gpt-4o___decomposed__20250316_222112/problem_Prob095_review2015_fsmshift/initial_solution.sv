module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    logic [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 3'b100; // Initialize counter to 4
            shift_ena <= 1'b1;     // Assert shift_ena
        end else if (cycle_count != 3'b000) begin
            cycle_count <= cycle_count - 1'b1; // Decrement counter
            shift_ena <= 1'b1;                 // Keep shift_ena asserted
        end else begin
            shift_ena <= 1'b0; // Deassert shift_ena
        end
    end

endmodule