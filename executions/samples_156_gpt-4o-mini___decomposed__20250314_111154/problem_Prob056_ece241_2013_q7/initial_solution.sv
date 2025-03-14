module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

logic Qold;

always @(posedge clk) begin
    case ({j, k})
        2'b00: Qold <= Qold;      // Qold
        2'b01: Qold <= 1'b0;      // Reset
        2'b10: Qold <= 1'b1;      // Set
        2'b11: Qold <= ~Qold;     // Toggle
    endcase
end

assign Q = Qold;

endmodule