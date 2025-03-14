module TopModule (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [15:0] c,
    input  logic [15:0] d,
    input  logic [15:0] e,
    input  logic [15:0] f,
    input  logic [15:0] g,
    input  logic [15:0] h,
    input  logic [15:0] i,
    input  logic [3:0]  sel,
    output logic [15:0] out
);

    always @(*) begin
        case (sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            4'd8: out = i;
            default: out = 16'b1111_1111_1111_1111;
        endcase
    end

endmodule