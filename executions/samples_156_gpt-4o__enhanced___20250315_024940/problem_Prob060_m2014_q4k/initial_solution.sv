module TopModule (
    input logic clk,
    input logic resetn,
    input logic in,
    output logic out
);

    // Internal signals for the 4 D flip-flops
    logic [3:0] shift_reg;

    // Sequential logic for the shift register with synchronous reset
    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Reset all flip-flops to 0
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift operation
        end
    end

    // Output assignment from the most significant bit of the shift register
    assign out = shift_reg[3];

endmodule