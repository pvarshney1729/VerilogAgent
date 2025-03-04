```verilog
module TopModule (
    input logic clk,
    input logic resetn,
    input logic [1:0] byteena,
    input logic [15:0] d,
    output logic [15:0] q
);

    always_ff @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0;
        end else begin
            case (byteena)
                2'b11: q <= d;
                2'b10: q[15:8] <= d[15:8];
                2'b01: q[7:0] <= d[7:0];
                default: q <= q; // Retain previous state
            endcase
        end
    end

endmodule
```