module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    always_ff @(posedge clk or posedge R) begin
        if (R) begin
            Q <= 1'b0;
        end else begin
            if (L) begin
                Q <= R;
            end else if (E) begin
                Q <= w;
            end
        end
    end

endmodule