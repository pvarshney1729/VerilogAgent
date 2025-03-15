module TopModule (
    input  logic clk,
    input  logic w,
    input  logic R,
    input  logic E,
    input  logic L,
    output logic Q
);

    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0; // Reset Q to 0
        end else if (L) begin
            Q <= 1'b1; // Load value 1 when L is asserted
        end else if (E) begin
            Q <= w; // Shift operation
        end
    end

endmodule