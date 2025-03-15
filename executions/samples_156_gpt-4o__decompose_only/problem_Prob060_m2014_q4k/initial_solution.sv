module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic in,
    output logic out
);

    // 4-bit shift register
    logic [3:0] shift_reg;

    // Sequential logic with synchronous active-low reset
    always @(posedge clk) begin
        if (!resetn)
            shift_reg <= 4'b0000; // Reset all flip-flops to 0
        else
            shift_reg <= {shift_reg[2:0], in}; // Shift input through the register
    end

    // Output the last bit of the shift register
    assign out = shift_reg[3];

endmodule