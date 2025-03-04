module TopModule(
    input wire a,  // Input port 'a'
    input wire b,  // Input port 'b'
    output wire out // Output port 'out', result of AND operation
);

    // Combinational logic for AND operation
    assign out = a & b;

endmodule