module TopModule (
    input logic clk,
    input logic in,
    output logic out
);

    logic d_ff_out;

    // Combinational logic for XOR
    always @(*) begin
        d_ff_out = in ^ out;
    end

    // D flip-flop
    always @(posedge clk) begin
        out <= d_ff_out;
    end

    // Initialize out to zero in simulation
    initial begin
        out = 1'b0;
    end

endmodule