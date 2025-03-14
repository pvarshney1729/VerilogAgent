module TopModule (
    input logic c,               // Input signal c (1 bit)
    input logic d,               // Input signal d (1 bit)
    output logic [3:0] mux_in    // Output mux_in (4 bits, LSB mux_in[0] to MSB mux_in[3])
);

logic a;                        // Selector input a for mux
logic b;                        // Selector input b for mux

// The logic of this module is combinational
// Initialize output mux_in to 0
initial begin
    mux_in = 4'b0000;         
end

// Implementation based on Karnaugh Map
always @(*) begin
    // Assign values to mux_in based on the K-map
    // ab = 00 -> mux_in[0]
    // ab = 01 -> mux_in[1]
    // ab = 10 -> mux_in[2]
    // ab = 11 -> mux_in[3]

    case ({c, d})             // Using c and d as a 2-bit selector
        2'b00: mux_in = 4'b0001; // K-map entry for ab=00
        2'b01: mux_in = 4'b1000; // K-map entry for ab=01
        2'b10: mux_in = 4'b1100; // K-map entry for ab=10
        2'b11: mux_in = 4'b1110; // K-map entry for ab=11
        default: mux_in = 4'b0000; // Default case for safety
    endcase
end

endmodule