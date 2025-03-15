module TopModule(
    input logic clk,
    input logic resetn,
    input logic in,
    output logic out
);

    // Internal registers for the shift register
    logic [3:0] shift_reg;

    // Sequential logic for the shift register with synchronous reset
    always @(posedge clk) begin
        if (!resetn) begin
            // Synchronous active-low reset
            shift_reg <= 4'b0000;
        end else begin
            // Shift operation
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    // Output assignment
    assign out = shift_reg[3];

endmodule