[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr_next;
    logic [4:0] lfsr;

    always @(*) begin
        if (reset) begin
            lfsr_next = 5'b00001; // Reset to 1
        end else begin
            lfsr_next = {lfsr[3] ^ lfsr[4], lfsr[4], lfsr[3], lfsr[2], lfsr[1]}; // Galois LFSR with taps at 5 and 3
        end
    end

    always @(posedge clk) begin
        lfsr <= lfsr_next;
    end

    assign q = lfsr;

endmodule
[DONE]