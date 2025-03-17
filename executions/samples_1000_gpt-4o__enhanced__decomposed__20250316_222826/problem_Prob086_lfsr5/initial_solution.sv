module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr <= 5'b00001; // Synchronous reset to initial state
        end else begin
            // Galois LFSR logic with taps at positions 5 and 3
            lfsr <= {lfsr[3:0], lfsr[4] ^ lfsr[2]};
        end
    end

    assign q = lfsr; // Assign internal LFSR state to output

endmodule