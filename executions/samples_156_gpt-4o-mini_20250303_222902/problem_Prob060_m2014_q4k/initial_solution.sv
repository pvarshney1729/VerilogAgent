module TopModule (
    input logic clk,        // Clock signal, positive edge triggered
    input logic resetn,     // Active-low synchronous reset
    input logic in,         // Serial input to the shift register
    output logic out        // Serial output from the shift register
);

logic [3:0] shift_reg;

always @(posedge clk) begin
    if (!resetn) begin
        shift_reg <= 4'b0000;
    end else begin
        shift_reg <= {shift_reg[2:0], in};
    end
end

assign out = shift_reg[0];

endmodule