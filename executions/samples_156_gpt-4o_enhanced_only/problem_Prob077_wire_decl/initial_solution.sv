module TopModule(
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out,
    output wire out_n
);
    // Intermediate wires for AND gate outputs
    wire and1_out;
    wire and2_out;
    
    // AND gates
    assign and1_out = a & b;
    assign and2_out = c & d;
    
    // OR gate
    assign out = and1_out | and2_out;
    
    // NOT gate for inverted output
    assign out_n = ~out;
    
endmodule