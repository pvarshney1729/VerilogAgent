[BEGIN]
module TopModule (
    input logic [3:0] in,
    output logic [1:0] pos
);

always @(*) begin
    pos = 2'b00; // Default output
    casez (in)
        4'b1???: pos = 2'b11; // Fourth bit
        4'b01??: pos = 2'b10; // Third bit
        4'b001?: pos = 2'b01; // Second bit
        4'b0001: pos = 2'b00; // First bit
        default: pos = 2'b00; // Ensure a defined output for all other cases
    endcase
end

endmodule
[DONE]