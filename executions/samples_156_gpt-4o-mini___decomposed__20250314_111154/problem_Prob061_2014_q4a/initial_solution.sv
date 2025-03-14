module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);
    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load R when L is asserted
        end else if (E) begin
            Q <= w; // Shift in w when E is asserted
        end
    end
endmodule