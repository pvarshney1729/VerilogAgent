module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] lfsr_out
);

    logic [3:0] lfsr_reg;

    always @(*) begin
        if (reset) begin
            lfsr_reg = 4'b0000; // Initialize to zero on reset
        end else begin
            // LFSR state transition logic
            lfsr_reg = {lfsr_reg[2:0], lfsr_reg[3] ^ lfsr_reg[1]}; // Example feedback polynomial
        end
    end

    assign lfsr_out = lfsr_reg;

endmodule