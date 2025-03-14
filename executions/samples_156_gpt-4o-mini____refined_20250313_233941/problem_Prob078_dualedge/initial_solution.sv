[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic d_ff1, d_ff2;

    always @(*) begin
        d_ff1 = d;
        d_ff2 = d_ff1;
    end

    always @(posedge clk) begin
        q <= d_ff1; // First flip-flop
    end

    always @(posedge clk) begin
        q <= d_ff2; // Second flip-flop
    end

endmodule
[DONE]