module ShiftLoad(
    input logic clk,
    input logic L,
    input logic E,
    input logic [3:0] data_in,
    output logic [3:0] w
);

    always_ff @(posedge clk) begin
        if (L) begin
            w <= data_in;
        end else if (E) begin
            w <= {w[2:0], 1'b0}; // Shift left by 1 bit
        end
    end

endmodule