module TopModule (
    input logic clk,
    input logic reset_n,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000;
        end else begin
            if (shift_ena) begin
                q <= {q[2:0], data};
            end else if (count_ena) begin
                q <= q - 1'b1;
            end
        end
    end

endmodule