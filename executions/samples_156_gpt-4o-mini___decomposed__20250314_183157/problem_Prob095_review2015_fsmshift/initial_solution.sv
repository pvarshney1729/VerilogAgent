module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);
    logic [1:0] cycle_count; // 2-bit counter to count 4 cycles

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 2'b00; // Reset counter
        end else if (cycle_count < 2'b11) begin
            cycle_count <= cycle_count + 1; // Increment counter
        end
    end

    assign shift_ena = (cycle_count < 2'b11); // Assert shift_ena for 4 cycles (0 to 3)

endmodule