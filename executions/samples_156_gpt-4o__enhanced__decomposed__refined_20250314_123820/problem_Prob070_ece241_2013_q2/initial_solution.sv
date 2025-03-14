[BEGIN]
module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out_sop,
    output logic out_pos
);

    always @(*) begin
        out_sop = (~d & ~c & b & ~a) |  // 4'b0010
                  (~d & c & b & a)  |  // 4'b0111
                  (d & c & b & a);     // 4'b1111
    end

    always @(*) begin
        out_pos = (d | c | ~b | a) &
                  (d | ~c | ~b | ~a) &
                  (~d | c | b | a);
    end

endmodule

module TopModule_testbench;
    logic a, b, c, d;
    logic out_sop, out_pos;

    TopModule uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .out_sop(out_sop),
        .out_pos(out_pos)
    );

    initial begin
        // Test cases to verify functionality
        a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; // 2
        #10;
        a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b0; // 7
        #10;
        a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b1; // 15
        #10;
        a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; // 0
        #10;
        // Add more test cases as needed
    end

endmodule
[DONE]