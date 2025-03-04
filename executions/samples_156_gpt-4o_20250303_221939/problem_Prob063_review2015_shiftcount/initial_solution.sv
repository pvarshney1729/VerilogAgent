module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    input logic reset,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (shift_ena) begin
            q <= {data, q[3:1]};
        end else if (count_ena) begin
            q <= q - 1'b1;
        end
    end

endmodule