module TopModule(
    input  logic clk,
    input  logic reset,
    output logic [4:0] q
);
    // Internal register to hold the current state of the LFSR
    logic [4:0] lfsr_reg;

    // Sequential logic block triggered on the positive edge of the clock
    always_ff @(posedge clk) begin
        if (reset) begin
            // Synchronous reset to initialize LFSR to 1
            lfsr_reg <= 5'b00001;
        end else begin
            // Galois LFSR with taps at bit positions 5 and 3
            lfsr_reg[4] <= lfsr_reg[0] ^ lfsr_reg[2]; // Tap at position 3
            lfsr_reg[3] <= lfsr_reg[4];
            lfsr_reg[2] <= lfsr_reg[3];
            lfsr_reg[1] <= lfsr_reg[2];
            lfsr_reg[0] <= lfsr_reg[1];
        end
    end

    // Assign the LFSR register to the output
    assign q = lfsr_reg;

endmodule