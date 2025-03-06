module TopModule (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);

    logic Output_A1, Output_B1;
    logic Output_A2, Output_B2;
    logic OR_out, AND_out;

    // Instantiate Module A1
    A A1 (
        .x(x),
        .y(y),
        .z(Output_A1)
    );

    // Instantiate Module B1
    B B1 (
        .x(x),
        .y(y),
        .z(Output_B1)
    );

    // Instantiate Module A2
    A A2 (
        .x(x),
        .y(y),
        .z(Output_A2)
    );

    // Instantiate Module B2
    B B2 (
        .x(x),
        .y(y),
        .z(Output_B2)
    );

    // OR gate
    assign OR_out = Output_A1 | Output_B1;

    // AND gate
    assign AND_out = Output_A2 & Output_B2;

    // XOR gate
    assign z = OR_out ^ AND_out;

endmodule

module A (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);
    assign z = (x ^ y) & x;
endmodule

module B (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);
    always @(*) begin
        // Assuming a specific combinational logic for B based on waveform
        // This logic needs to be defined based on the waveform provided
        z = x & ~y;  // Example logic, replace with actual logic from waveform
    end
endmodule