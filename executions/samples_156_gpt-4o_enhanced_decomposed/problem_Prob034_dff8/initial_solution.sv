module TopModule(
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Sequential logic for 8 D flip-flops
    always_ff @(posedge clk) begin
        q <= d;
    end

    // Initial block for simulation purposes
    initial begin
        q = 8'b0;
    end

endmodule