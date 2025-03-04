module TopModule(
    output wire out // 1-bit wire output, always driven to '0'
);

    // Continuous assignment to drive output 'out' to logic low
    assign out = 1'b0;

endmodule