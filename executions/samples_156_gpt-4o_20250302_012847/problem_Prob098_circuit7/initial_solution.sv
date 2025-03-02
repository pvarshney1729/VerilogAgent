module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    always_ff @(posedge clk) begin
        q <= q ^ a; // Toggle q based on input a
    end

    initial begin
        q = 1'b0; // Initialize q to zero in simulation
    end

endmodule