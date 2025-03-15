module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic [4:0] a, b, c; // Intermediate signals for full adder

    always @(*) begin
        {c[0], a[0]} = x[0] + y[0]; // Full adder for bit 0
        {c[1], a[1]} = x[1] + y[1] + c[0]; // Full adder for bit 1
        {c[2], a[2]} = x[2] + y[2] + c[1]; // Full adder for bit 2
        {c[3], a[3]} = x[3] + y[3] + c[2]; // Full adder for bit 3
        sum = {c[3], a[3:0]}; // Concatenate overflow bit with sum
    end

endmodule