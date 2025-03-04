module TopModule(
    input  logic [4:0] a, // 5-bit unsigned input
    input  logic [4:0] b, // 5-bit unsigned input
    input  logic [4:0] c, // 5-bit unsigned input
    input  logic [4:0] d, // 5-bit unsigned input
    input  logic [4:0] e, // 5-bit unsigned input
    input  logic [4:0] f, // 5-bit unsigned input
    output logic [7:0] w, // 8-bit unsigned output
    output logic [7:0] x, // 8-bit unsigned output
    output logic [7:0] y, // 8-bit unsigned output
    output logic [7:0] z  // 8-bit unsigned output
);

    always @(*) begin
        // Concatenate inputs and append two '1' bits
        logic [31:0] concatenated_vector;
        concatenated_vector = {a, b, c, d, e, f, 2'b11};

        // Split the concatenated vector into outputs
        w = concatenated_vector[31:24];
        x = concatenated_vector[23:16];
        y = concatenated_vector[15:8];
        z = concatenated_vector[7:0];
    end

endmodule