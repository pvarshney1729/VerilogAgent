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
            Q <= R; // Load value R when L is asserted
        end else if (E) begin
            Q <= w; // Shift value w when E is asserted
        end
    end

    initial begin
        Q = 1'b0; // Initialize Q to zero
    end

endmodule