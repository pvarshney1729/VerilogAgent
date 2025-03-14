module TopModule (
    input logic input_a,    // First bit to be added
    input logic input_b,    // Second bit to be added
    input logic input_cin,  // Carry-in bit
    output logic output_cout,// Carry-out bit
    output logic output_sum  // Sum of the three bits
);
    assign output_sum = input_a ^ input_b ^ input_cin;
    assign output_cout = (input_a & input_b) | (input_cin & (input_a ^ input_b));
endmodule