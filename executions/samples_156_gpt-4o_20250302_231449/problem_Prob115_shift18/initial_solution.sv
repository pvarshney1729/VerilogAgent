```verilog
module TopModule (
    input wire clk,
    input wire rst_n,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 64'b0;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0}; // Shift left by 1
                2'b01: q <= {q[55:0], 8'b0}; // Shift left by 8
                2'b10: q <= {q[63], q[63:1]}; // Arithmetic shift right by 1
                2'b11: q <= {{8{q[63]}}, q[63:8]}; // Arithmetic shift right by 8
                default: q <= q; // Default case to hold value
            endcase
        end
    end

endmodule
```