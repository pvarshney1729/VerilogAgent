module TopModule (
    input logic clk,
    input logic [7:0] d,
    output logic [7:0] q
);

    // On the positive edge of the clock, update the output q with the input d
    always @(posedge clk) begin
        q <= d;
    end

    // Initialize q to zero
    initial begin
        q = 8'b00000000;
    end

endmodule