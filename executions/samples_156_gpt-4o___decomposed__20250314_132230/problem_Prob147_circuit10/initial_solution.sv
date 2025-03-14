module TopModule (
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic q,
    output logic state
);

    logic state_reg;

    always @(posedge clk) begin
        if (a && b)
            state_reg <= ~state_reg;
        else if (a && ~b)
            state_reg <= 1'b0;
        else if (~a && b)
            state_reg <= 1'b1;
        else
            state_reg <= state_reg;
    end

    always @(*) begin
        q = state_reg;
    end

    assign state = state_reg;

endmodule