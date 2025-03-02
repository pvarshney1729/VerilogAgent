module d_flip_flop (
    input logic clk,
    input logic reset,
    input logic d,
    output logic q
);
    always @(*) begin
        if (reset) begin
            q = 1'b0;
        end else begin
            q = d;
        end
    end

    initial begin
        q = 1'b0;
    end
endmodule