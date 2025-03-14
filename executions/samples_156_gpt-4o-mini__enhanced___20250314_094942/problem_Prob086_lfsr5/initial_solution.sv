module TopModule (
    input logic clk,               // Clock input, triggered on the rising edge
    input logic reset,             // Active-high synchronous reset
    output logic [4:0] q           // 5-bit output representing the LFSR state
);

// Bit ordering convention: q[0] is the least significant bit (LSB), q[4] is the most significant bit (MSB)

// Define the LFSR taps based on Galois configuration
localparam TAP1 = 4; // Bit position 5 (index 4)
localparam TAP2 = 2; // Bit position 3 (index 2)

// Initial state of LFSR (upon reset)
initial begin
    q = 5'b00001; // Initialize LFSR to non-zero state (1)
end

// Sequential logic for LFSR operation
always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset LFSR output to 1
    end else begin
        // Shift right: new bit = XOR of the tap positions with the LSB
        // Calculate the new bit based on tap positions
        q[0] <= q[TAP1] ^ q[TAP2]; // XOR tap bits to generate new LSB
        // Shift remaining bits right
        q[4:1] <= q[3:0]; // Shift bits right
    end
end

// Note: The LFSR cycles through 2^5 - 1 = 31 states before repeating, with all-zero state never reached.
endmodule