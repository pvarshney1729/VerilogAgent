module TopModule (
    input logic x,         // Input signal x: 1-bit unsigned
    input logic y,         // Input signal y: 1-bit unsigned
    output logic z         // Output signal z: 1-bit unsigned
);

// Initial State
initial begin
    z = 1'b1; // Initial state of z as per provided waveform
end

// Combinational Logic Behavior
always @(*) begin
    case ({x, y})
        2'b00: z = 1'b1;  // When both x and y are 0
        2'b01: z = 1'b0;  // When x is 0 and y is 1
        2'b10: z = 1'b0;  // When x is 1 and y is 0
        2'b11: z = 1'b1;  // When both x and y are 1
        default: z = 1'b0; // Default case should be defined to handle unexpected values
    endcase
end

endmodule