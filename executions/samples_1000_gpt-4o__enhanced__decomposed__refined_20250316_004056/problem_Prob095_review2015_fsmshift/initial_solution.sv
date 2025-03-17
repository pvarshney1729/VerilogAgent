module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    logic [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 3'd4; // Initialize counter to 4 on reset
            shift_ena <= 1'b1;   // Assert shift_ena on reset
        end else if (cycle_count != 3'd0) begin
            cycle_count <= cycle_count - 1; // Decrement counter
            shift_ena <= 1'b1;              // Keep shift_ena high while counting
        end else begin
            shift_ena <= 1'b0;              // Deassert shift_ena when count is 0
        end
    end

endmodule