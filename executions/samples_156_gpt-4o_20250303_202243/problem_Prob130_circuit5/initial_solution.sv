module TopModule (
    input logic [3:0] a,
    input logic [3:0] b,
    input logic [3:0] c,
    input logic [3:0] d,
    input logic [3:0] e,
    output logic [3:0] q
);

    always_comb begin
        case (c)
            4'd0: q = b;
            4'd1: q = e;
            4'd2: q = a;
            4'd3: q = d;
            default: q = 4'hF; // Outputs 'f' for c >= 4 as per pattern
        endcase
    end

endmodule