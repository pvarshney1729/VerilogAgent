```verilog
module TopModule(
    input logic clk,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic [63:0] data,
    output logic [63:0] q
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0}; // Shift left by 1
                2'b01: q <= {q[55:0], 8'b0}; // Shift left by 8
                2'b10: q <= {q[63], q[63:1]}; // Arithmetic shift right by 1
                2'b11: q <= {{8{q[63]}}, q[63:8]}; // Arithmetic shift right by 8
                default: q <= q; // No operation for undefined amount
            endcase
        end
    end

    initial begin
        q = 64'b0;
    end

endmodule
```