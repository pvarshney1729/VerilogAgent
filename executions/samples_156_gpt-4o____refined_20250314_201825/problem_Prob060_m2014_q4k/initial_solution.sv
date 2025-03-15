module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic in,
    output logic out
);

    // Internal signals for the shift register
    logic [3:0] shift_reg;

    // Sequential logic for the shift register with synchronous reset
    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000; // Initialize all flip-flops to zero
        end else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift left and input new bit
        end
    end

    // Output the last bit of the shift register
    assign out = shift_reg[3];

endmodule