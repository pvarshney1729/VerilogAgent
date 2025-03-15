module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    // Initialize q to 0 at the beginning of simulation
    initial begin
        q = 1'b0;
    end

    always @(posedge clk) begin
        q <= d;
    end
endmodule