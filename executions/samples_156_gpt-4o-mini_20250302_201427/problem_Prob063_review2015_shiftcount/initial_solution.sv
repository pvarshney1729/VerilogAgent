module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    input logic rst,
    output logic [3:0] q
);
    always @(posedge clk) begin
        if (rst) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena) begin
                q <= {data, q[3:1]};
            end else if (count_ena) begin
                q <= q - 1;
            end
        end
    end
endmodule