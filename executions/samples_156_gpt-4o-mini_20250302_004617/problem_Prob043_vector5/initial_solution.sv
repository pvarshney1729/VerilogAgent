module comparator_5bit (
    input logic clk,
    input logic rst_n,
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic e,
    output logic [24:0] result
);

    always @(*) begin
        result = 25'b0; // Initialize result to zero
        result[0]  = (a == b); // a vs b
        result[1]  = (a == c); // a vs c
        result[2]  = (a == d); // a vs d
        result[3]  = (a == e); // a vs e
        result[4]  = (b == c); // b vs c
        result[5]  = (b == d); // b vs d
        result[6]  = (b == e); // b vs e
        result[7]  = (c == d); // c vs d
        result[8]  = (c == e); // c vs e
        result[9]  = (d == e); // d vs e
        result[10] = (a == b) && (a == c); // a vs b and a vs c
        result[11] = (a == b) && (a == d); // a vs b and a vs d
        result[12] = (a == b) && (a == e); // a vs b and a vs e
        result[13] = (a == c) && (a == d); // a vs c and a vs d
        result[14] = (a == c) && (a == e); // a vs c and a vs e
        result[15] = (a == d) && (a == e); // a vs d and a vs e
        result[16] = (b == c) && (b == d); // b vs c and b vs d
        result[17] = (b == c) && (b == e); // b vs c and b vs e
        result[18] = (b == d) && (b == e); // b vs d and b vs e
        result[19] = (c == d) && (c == e); // c vs d and c vs e
        result[20] = (a == b) && (c == d); // a vs b and c vs d
        result[21] = (a == c) && (b == d); // a vs c and b vs d
        result[22] = (a == d) && (b == e); // a vs d and b vs e
        result[23] = (c == e) && (d == e); // c vs e and d vs e
        result[24] = (a == b) && (c == e); // a vs b and c vs e
    end

endmodule