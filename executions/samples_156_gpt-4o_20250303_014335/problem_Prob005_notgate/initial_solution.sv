module TopModule (
    input wire in,
    output wire out
);
    assign out = ~in; // NOT gate implementation
endmodule