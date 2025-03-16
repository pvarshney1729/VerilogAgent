```verilog
module TopModule (
    input logic clk,          // Clock signal, single-bit
    input logic resetn,       // Synchronous active-low reset, single-bit
    input logic [1:0] byteena, // Byte-enable control, 2 bits
    input logic [15:0] d,     // Data input, 16 bits, unsigned
    output logic [15:0] q     // Data output, 16 bits, unsigned
);

always_ff @(posedge clk) begin
    if (!resetn) begin
        q <= 16'b0; // On reset, output register is cleared
    end else begin
        // Byte-enable controlled updates
        if (byteena[1]) begin
            q[15:8] <= d[15:8]; // Update upper byte
        end
        if (byteena[0]) begin
            q[7:0] <= d[7:0];   // Update lower byte
        end
    end
end

endmodule
```