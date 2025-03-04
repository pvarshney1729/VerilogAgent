module TopModule (
    input logic clk,
    input logic rst_n,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena && !count_ena) begin
                q <= {data, q[3:1]};
            end else if (count_ena && !shift_ena) begin
                q <= q - 1;
            end
        end
    end

endmodule