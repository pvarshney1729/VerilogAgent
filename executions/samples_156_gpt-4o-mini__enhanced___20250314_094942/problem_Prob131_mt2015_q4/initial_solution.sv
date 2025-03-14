module A (
    input logic x,    // 1-bit input
    input logic y,    // 1-bit input
    output logic z    // 1-bit output
);
    // Boolean function: z = (x ^ y) & x
    assign z = (x ^ y) & x;
endmodule

module B (
    input logic x,    // 1-bit input
    input logic y,    // 1-bit input
    output logic z    // 1-bit output
);
    // Output behavior based on simulation waveform
    always @(*) begin
        case ({x, y})
            2'b00: z = 1;  // For x=0, y=0
            2'b01: z = 0;  // For x=0, y=1
            2'b10: z = 0;  // For x=1, y=0
            2'b11: z = 1;  // For x=1, y=1
            default: z = 0; // Default case for safety
        endcase
    end
endmodule

module TopLevel (
    input logic x,    // 1-bit input
    input logic y,    // 1-bit input
    output logic z    // 1-bit output
);

    logic z_A1, z_A2, z_B1, z_B2; // Internal wires for submodule outputs

    // Instantiate Module A
    A A1 (.x(x), .y(y), .z(z_A1));
    A A2 (.x(x), .y(y), .z(z_A2));

    // Instantiate Module B
    B B1 (.x(x), .y(y), .z(z_B1));
    B B2 (.x(x), .y(y), .z(z_B2));

    // Logic Combination
    logic or_output = z_A1 | z_B1; // OR gate for first pair
    logic and_output = z_A2 & z_B2; // AND gate for second pair

    // Final output based on XOR operation
    assign z = or_output ^ and_output;

endmodule