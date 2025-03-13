```verilog
module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    input logic rst,  // Added reset input
    output logic Q   // Q is a logic type because it maintains state
);

always_ff @(posedge clk) begin
    if (rst) begin
        Q <= 1'b0; // Define reset behavior
    end else begin
        if (L) begin
            Q <= R;  // Load operation takes precedence
        end else if (E) begin
            Q <= w;  // Shift operation
        end
    end
end

endmodule
```