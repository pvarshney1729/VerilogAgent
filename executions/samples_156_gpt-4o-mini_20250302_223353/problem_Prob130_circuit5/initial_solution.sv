module TopModule (
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] c,
    input logic [3:0] d,
    input logic [3:0] e,
    output logic [3:0] q
);

    always @(*) begin
        case (c)
            4'b0000: q = b;
            4'b0001: q = e;
            4'b0010: q = a;
            4'b0011: q = d;
            4'b0100, 4'b0101, 4'b0110, 4'b0111, 
            4'b1000, 4'b1001: q = 4'b1111;
            default: q = 4'b0000; // For c > 4'b1001
        endcase
    end

endmodule