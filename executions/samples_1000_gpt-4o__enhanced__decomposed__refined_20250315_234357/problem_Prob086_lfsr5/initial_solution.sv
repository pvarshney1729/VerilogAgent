module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Synchronous reset to initial state
        end else begin
            // Galois LFSR logic with taps at positions 5 and 3
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end

endmodule