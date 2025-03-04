module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] out
);

    assign out = {
        (e == e), (e == d), (e == c), (e == b), (e == a),
        (d == e), (d == d), (d == c), (d == b), (d == a),
        (c == e), (c == d), (c == c), (c == b), (c == a),
        (b == e), (b == d), (b == c), (b == b), (b == a),
        (a == e), (a == d), (a == c), (a == b), (a == a)
    };

endmodule