module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [2:0] cycle_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            cycle_count <= 3'b100; // Initialize to 4 cycles
        end else if (cycle_count != 3'b000) begin
            cycle_count <= cycle_count - 1;
        end
    end

    always_comb begin
        shift_ena = (cycle_count != 3'b000);
    end

endmodule