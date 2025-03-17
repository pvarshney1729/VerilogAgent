module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);
    logic [2:0] q_reg;

    always_ff @(posedge clk) begin
        if (a) begin
            q_reg <= 3'd4;
        end else begin
            if (q_reg == 3'd6) begin
                q_reg <= 3'd0;
            end else begin
                q_reg <= q_reg + 3'd1;
            end
        end
    end

    assign q = q_reg;
endmodule