[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);

    always @(*) begin
        out = (a & ~b & ~c & ~d) | 
              (a & ~b & d) | 
              (a & b & ~c) | 
              (b & c & d) | 
              (c & ~d);
    end

endmodule
[DONE]