module TopModule (
    input wire clk,         // Clock signal, triggers on positive edge
    input wire reset,       // Synchronous active high reset
    output reg [31:0] q     // 32-bit output register representing the LFSR state
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Initialize LFSR to known state on reset
        end else begin
            // Compute new bit as XOR of tapped positions
            wire new_bit;
            new_bit = q[31] ^ q[21] ^ q[1] ^ q[0];
            q <= {new_bit, q[31:1]}; // Shift right and insert new_bit at MSB
        end
    end

endmodule