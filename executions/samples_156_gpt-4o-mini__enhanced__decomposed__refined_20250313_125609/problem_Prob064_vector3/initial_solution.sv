module TopModule (
    input  logic [4:0] a,    // Input vector a (5 bits, unsigned)
    input  logic [4:0] b,    // Input vector b (5 bits, unsigned)
    input  logic [4:0] c,    // Input vector c (5 bits, unsigned)
    input  logic [4:0] d,    // Input vector d (5 bits, unsigned)
    input  logic [4:0] e,    // Input vector e (5 bits, unsigned)
    input  logic [4:0] f,    // Input vector f (5 bits, unsigned)
    output logic [7:0] w,    // Output vector w (8 bits, unsigned)
    output logic [7:0] x,    // Output vector x (8 bits, unsigned)
    output logic [7:0] y,    // Output vector y (8 bits, unsigned)
    output logic [7:0] z     // Output vector z (8 bits, unsigned)
);

    // Concatenation and output assignment
    always @(*) begin
        // Concatenate inputs
        logic [29:0] concatenated_inputs = {a, b, c, d, e, f};
        
        // Assigning outputs
        w = {concatenated_inputs[7:0], 2'b11};  // Last two bits set to 1
        x = {concatenated_inputs[15:8], 2'b11}; // Last two bits set to 1
        y = {concatenated_inputs[23:16], 2'b11};// Last two bits set to 1
        z = {concatenated_inputs[29:24], 2'b11};// Last two bits set to 1
    end

endmodule