module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr;

    always @(posedge clk) begin
        if (reset) begin
            lfsr <= 5'b00001; // Reset state
        end else begin
            lfsr <= {lfsr[3:0], lfsr[4] ^ lfsr[2]}; // Shift and feedback
        end
    end

    assign q = lfsr;

endmodule