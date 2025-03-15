module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);
    logic Q_reg;

    always @(posedge clk) begin
        if (L) begin
            Q_reg <= R; // Load R into Q_reg when L is asserted
        end else if (E) begin
            Q_reg <= w; // Shift logic when E is asserted
        end
    end

    assign Q = Q_reg; // Assign Q_reg to output Q
endmodule