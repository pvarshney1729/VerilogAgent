```
[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

logic reset; // Assuming a reset signal (not defined in original spec)

initial begin
    q = 3'b000; // Initialize q to 0 at simulation start
end

always @(posedge clk) begin
    if (reset) begin
        q <= 3'b000; // Synchronous reset
    end else begin
        case (q)
            3'b000: if (a) q <= 3'b001;
            3'b001: if (a) q <= 3'b010; else q <= 3'b000;
            3'b010: if (a) q <= 3'b011; else q <= 3'b000;
            3'b011: if (a) q <= 3'b100; else q <= 3'b000;
            3'b100: if (a) q <= 3'b101; else q <= 3'b000;
            3'b101: if (a) q <= 3'b110; else q <= 3'b000;
            3'b110: if (a) q <= 3'b111; else q <= 3'b000;
            3'b111: if (a) q <= 3'b000; else q <= 3'b000;
            default: q <= 3'b000; // Default state for safety
        endcase
    end
end

endmodule
[DONE]
```