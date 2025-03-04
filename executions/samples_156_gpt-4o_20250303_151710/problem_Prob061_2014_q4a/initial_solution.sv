module TopModule (
    input logic clk,
    input logic reset_n,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            Q <= 1'b0;
        end else if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule