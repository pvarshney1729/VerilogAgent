```verilog
module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

logic reset; // Reset signal to be integrated

initial begin
    q = 3'b000;
end

always @(posedge clk) begin
    if (a == 1'b1) begin
        q <= 3'b100;
    end else begin
        case (q)
            3'b100: q <= 3'b101;
            3'b101: q <= 3'b110;
            3'b110: q <= 3'b000;
            3'b000: q <= 3'b001;
            default: q <= 3'b000;
        endcase
    end
end

endmodule
```