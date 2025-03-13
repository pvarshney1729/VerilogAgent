```verilog
[BEGIN]
module TopModule (
    input logic clk,               // 1-bit clock input
    input logic load,              // 1-bit load control, active high
    input logic ena,               // 1-bit enable control, active high
    input logic [1:0] amount,      // 2-bit control for shift amount and direction
    input logic [63:0] data,       // 64-bit input data
    output logic [63:0] q          // 64-bit shift register output
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;               // Shift left by 1
                2'b01: q <= q << 8;               // Shift left by 8
                2'b10: q <= {q[63], q[63:1]};     // Arithmetic right shift by 1
                2'b11: q <= {{8{q[63]}}, q[63:8]}; // Arithmetic right shift by 8
                default: q <= q;                  // Retain value for unexpected cases
            endcase
        end
    end

endmodule
[DONE]
```