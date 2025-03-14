module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);
    logic state_reg;

    always @(posedge clk) begin
        state_reg <= (a & ~b) | (state_reg & ~a);
    end

    assign state = state_reg;
    assign q = state_reg & a;

endmodule