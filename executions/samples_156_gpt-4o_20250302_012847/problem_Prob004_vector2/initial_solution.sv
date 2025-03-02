module combinational_logic (
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [1:0] sel,
    output logic [3:0] y
);

    always @(*) begin
        case (sel)
            2'b00: y = a & b;  // AND operation
            2'b01: y = a | b;  // OR operation
            2'b10: y = a ^ b;  // XOR operation
            2'b11: y = ~a;     // NOT operation on 'a'
            default: y = 4'b0000; // Default case
        endcase
    end

endmodule