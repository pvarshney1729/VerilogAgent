module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    initial begin
        Q = 1'b0;
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule