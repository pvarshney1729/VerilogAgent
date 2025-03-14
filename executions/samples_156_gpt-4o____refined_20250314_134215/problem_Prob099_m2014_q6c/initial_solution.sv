[BEGIN]
module TopModule (
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    // Next-state logic for Y2 (y[1])
    logic Y2;
    always @(*) begin
        Y2 = (y[0] & ~w) | (y[3] & w);
    end

    // Next-state logic for Y4 (y[3])
    logic Y4;
    always @(*) begin
        Y4 = (y[1] & w) | (y[2] & w) | (y[5] & w);
    end

    // Output logic
    assign Y1 = y[4];
    assign Y3 = y[3];

endmodule
[DONE]