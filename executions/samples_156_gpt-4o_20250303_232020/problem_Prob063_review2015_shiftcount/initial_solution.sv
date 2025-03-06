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
    end else if (shift_ena && !count_ena) begin
        q <= {q[2:0], data};
    end else if (count_ena && !shift_ena) begin
        q <= q - 1;
    end
    // If both `shift_ena` and `count_ena` are high, behavior is indeterminate.
end

endmodule