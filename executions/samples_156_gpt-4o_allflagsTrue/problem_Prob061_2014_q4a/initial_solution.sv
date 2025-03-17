module TopModule (
    input  logic clk,
    input  logic w,
    input  logic R,
    input  logic E,
    input  logic L,
    output logic Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load operation
        end else if (E) begin
            Q <= w; // Shift operation
        end
    end

endmodule