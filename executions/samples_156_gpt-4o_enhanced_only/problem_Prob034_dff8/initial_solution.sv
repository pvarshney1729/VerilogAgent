module TopModule(
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Sequential logic for D flip-flops
    always_ff @(posedge clk) begin
        q <= d;
    end

endmodule