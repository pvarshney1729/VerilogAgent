module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic d_pos, d_neg;

    always_ff @(posedge clk) begin
        d_pos <= d;
    end

    always_ff @(negedge clk) begin
        d_neg <= d;
    end

    always_comb begin
        q = clk ? d_pos : d_neg;
    end
endmodule