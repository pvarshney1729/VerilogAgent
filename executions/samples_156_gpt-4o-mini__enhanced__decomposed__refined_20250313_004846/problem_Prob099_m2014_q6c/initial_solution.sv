[BEGIN]
module TopModule (
    input  logic [5:0] y,
    input  logic       w,
    output logic       Y1,
    output logic       Y3,
    output logic       Y2,
    output logic       Y4
);
    always @(*) begin
        Y1 = y[4] | y[5]; // States E or F output 1
        Y3 = y[2] | y[3] | y[4]; // States C, D, or E output 1
        Y2 = (y[0] & 1'b0) | (y[1] & 1'b0); // Transition to B from A or stays in B when w = 0
        Y4 = (y[1] & w) | (y[2] & w) | (y[4] & w) | (y[5] & w); // Transition to D from B, C, E, or F when w = 1
    end
endmodule
[DONE]