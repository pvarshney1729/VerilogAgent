module TopModule (
    input  logic clk,       // Clock signal, positive edge triggered
    input  logic resetn,    // Active-low, synchronous reset
    input  logic in,        // Input bit for the shift register
    output logic out        // Output bit from the shift register
);

    logic [3:0] shift_reg; // 4-bit register to store the shift register values

    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000;
        end else begin
            shift_reg <= {in, shift_reg[3:1]};
        end
    end

    assign out = shift_reg[0]; // Connect the LSB of the shift register to the output port 'out'

endmodule