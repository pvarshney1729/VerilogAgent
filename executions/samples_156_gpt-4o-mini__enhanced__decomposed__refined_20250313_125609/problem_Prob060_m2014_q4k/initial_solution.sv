[BEGIN]
module TopModule (
    input logic clk,      // Clock input
    input logic resetn,  // Active-low synchronous reset
    input logic in,      // Data input
    output logic out     // Data output
);

logic [3:0] shift_reg;    // 4-bit shift register

always @(posedge clk) begin
    if (!resetn) begin
        shift_reg <= 4'b0000;  
        out <= 1'b0;           
    end else begin
        shift_reg <= {shift_reg[2:0], in};  
        out <= shift_reg[3];                
    end
end

endmodule
[DONE]