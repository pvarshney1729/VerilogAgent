module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [4:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            q <= {q[4] ^ q[2], q[4], q[3], q[2], q[1]}; // Galois LFSR with taps at 5 and 3
        end
    end

endmodule