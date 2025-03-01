```verilog
module TopModule (
    input  logic        clk,      // Clock signal for synchronous operations
    input  logic        load,     // Active high signal to load data into the register
    input  logic        ena,      // Active high signal to enable shifting
    input  logic [1:0]  amount,   // 2-bit control signal to select shift operation
    input  logic [63:0] data,     // 64-bit input data to be loaded
    output logic [63:0] q         // 64-bit output representing register content
);

    // Initialize q to zero
    initial begin
        q = 64'b0;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;  // Shift left by 1 bit
                2'b01: q <= q << 8;  // Shift left by 8 bits
                2'b10: q <= $signed(q) >>> 1;  // Arithmetic shift right by 1 bit
                2'b11: q <= $signed(q) >>> 8;  // Arithmetic shift right by 8 bits
                default: q <= q;  // No operation
            endcase
        end
    end

endmodule
```