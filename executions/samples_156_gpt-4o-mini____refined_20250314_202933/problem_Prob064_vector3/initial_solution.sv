module TopModule (
    input logic [4:0] a,
    input logic [4:0] b,
    input logic [4:0] c,
    input logic [4:0] d,
    input logic [4:0] e,
    input logic [4:0] f,
    output logic [7:0] w,
    output logic [7:0] x,
    output logic [7:0] y,
    output logic [7:0] z
);

    logic [29:0] concatenated_inputs;
    
    assign concatenated_inputs = {a, b, c, d, e, f, 2'b11}; // Concatenate inputs and two 1 bits

    assign w = concatenated_inputs[7:0];   // Assign lower 8 bits to w
    assign x = concatenated_inputs[15:8];  // Assign next 8 bits to x
    assign y = concatenated_inputs[23:16]; // Assign next 8 bits to y
    assign z = concatenated_inputs[31:24]; // Assign upper 8 bits to z

endmodule