module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);
    logic q_reg;

    always @(posedge clk) begin
        if (a && ~b) begin
            q_reg <= 1;
        end else if (~a && b) begin
            q_reg <= 0;
        end
        // Retain state when both a and b are low
    end

    assign q = q_reg;
    assign state = q_reg;

endmodule