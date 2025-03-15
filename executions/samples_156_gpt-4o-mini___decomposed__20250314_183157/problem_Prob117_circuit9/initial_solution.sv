module TopModule (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        case (q)
            3'b100: if (a) q <= 3'b100; else q <= 3'b100; // 4
            3'b101: if (a) q <= 3'b110; else q <= 3'b000; // 5
            3'b110: if (a) q <= 3'b000; else q <= 3'b001; // 6
            3'b000: if (a) q <= 3'b001; else q <= 3'b000; // 0
            3'b001: if (a) q <= 3'b100; else q <= 3'b000; // 1
            default: q <= 3'b100; // reset to state 4
        endcase
    end

endmodule