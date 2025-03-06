module TopModule(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    always_comb begin
        sum = a ^ b ^ cin;
        cout = (a & b) | (b & cin) | (a & cin);
    end

endmodule