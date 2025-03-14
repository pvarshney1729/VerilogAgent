module TopModule (
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] c,
    input logic [3:0] d,
    input logic [3:0] e,
    input logic reset,
    output logic [3:0] q
);

    always @(*) begin
        if (!reset) begin
            q = 4'b0000;
        end else begin
            case (c)
                4'b0000: q = b; // c = 0
                4'b0001: q = e; // c = 1
                4'b0010: q = a; // c = 2
                4'b0011: q = d; // c = 3
                4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001: q = 4'b1111; // f for c = 4 to 9
                default: q = 4'b0000; // Default case for c >= 10
            endcase
        end
    end

endmodule