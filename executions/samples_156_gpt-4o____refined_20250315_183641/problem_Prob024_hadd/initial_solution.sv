module TopModule (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);

    // Combinational logic for half adder
    always @(*) begin
        sum  = a ^ b;  // Sum is the XOR of inputs
        cout = a & b;  // Carry-out is the AND of inputs
    end

endmodule