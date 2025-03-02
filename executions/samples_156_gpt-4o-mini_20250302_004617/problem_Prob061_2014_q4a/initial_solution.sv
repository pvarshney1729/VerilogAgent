module TopModule (
    input logic clk,
    input logic reset,
    input logic L,
    input logic E,
    input logic [3:0] R,
    input logic [3:0] w,
    output logic [3:0] Q
);

    always @(posedge clk) begin
        if (reset) begin
            Q <= 4'b0000;
        end else if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= {Q[2:0], w[0]};
        end
    end

endmodule