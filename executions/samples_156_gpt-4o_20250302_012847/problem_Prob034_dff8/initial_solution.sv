module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Initialize q to 8'b00000000 at the start of the simulation
    initial begin
        q = 8'b00000000;
    end

    // Sequential logic with synchronous reset omitted
    always_ff @(posedge clk) begin
        q <= d;
    end

endmodule