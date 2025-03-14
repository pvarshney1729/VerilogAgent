module TopModule(
    input logic clk,
    input logic d,
    output logic q
);
    logic d_rising, d_falling;

    always_ff @(posedge clk) begin
        d_rising <= d;
    end

    always_ff @(negedge clk) begin
        d_falling <= d;
    end

    always_comb begin
        if (clk == 1'b1) begin
            q = d_rising;
        end else begin
            q = d_falling;
        end
    end
endmodule