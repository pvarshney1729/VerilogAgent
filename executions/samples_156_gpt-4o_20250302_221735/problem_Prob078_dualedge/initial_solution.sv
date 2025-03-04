module TopModule (
    input logic clk,
    input logic d,
    input logic rst_n,
    output logic q
);

logic q_rise, q_fall;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q_rise <= 1'b0;
    else
        q_rise <= d;
end

always_ff @(negedge clk or negedge rst_n) begin
    if (!rst_n)
        q_fall <= 1'b0;
    else
        q_fall <= d;
end

always_comb begin
    q = clk ? q_rise : q_fall;
end

endmodule