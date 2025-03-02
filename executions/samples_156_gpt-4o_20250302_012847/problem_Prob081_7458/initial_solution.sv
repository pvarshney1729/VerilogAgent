module combinational_logic(
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [1:0] sel,
    output logic [3:0] result
);

    always @(*) begin
        case (sel)
            2'b00: result = a & b; // AND operation
            2'b01: result = a | b; // OR operation
            2'b10: result = a ^ b; // XOR operation
            2'b11: result = ~a;    // NOT operation on 'a'
            default: result = 4'b0000;
        endcase
    end

endmodule