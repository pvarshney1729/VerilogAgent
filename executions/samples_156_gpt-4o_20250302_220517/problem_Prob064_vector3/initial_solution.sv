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

    // Intermediate 32-bit vector
    logic [31:0] concatenated_vector;

    // Concatenation and splitting logic
    always_comb begin
        concatenated_vector = {a, b, c, d, e, f, 2'b11};
        w = concatenated_vector[31:24];
        x = concatenated_vector[23:16];
        y = concatenated_vector[15:8];
        z = concatenated_vector[7:0];
    end

endmodule