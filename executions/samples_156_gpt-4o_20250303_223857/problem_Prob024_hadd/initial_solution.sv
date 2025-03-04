module TopModule(
    input logic i_a,
    input logic i_b,
    output logic o_sum,
    output logic o_cout
);

    // Combinational logic for half-adder
    assign o_sum = i_a ^ i_b;  // XOR operation for sum
    assign o_cout = i_a & i_b; // AND operation for carry-out

endmodule