module TopModule (
    logic in1,
    logic in2,
    logic out
);
    assign out = in1 & ~in2;
endmodule