module TopModule (
    input logic clk,
    input logic reset,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena) begin
                q <= {data, q[3:1]};
            end else if (count_ena) begin
                q <= (q == 4'b0000) ? 4'b1111 : q - 1;
            end
        end
    end

endmodule