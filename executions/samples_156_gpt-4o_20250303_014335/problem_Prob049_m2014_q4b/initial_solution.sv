module TopModule (
    input wire clk,  // Clock signal
    input wire ar,   // Asynchronous reset, active high
    input wire d,    // Data input
    output reg q     // D flip-flop output
);

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Reset output to 0
        end else begin
            q <= d;    // Sample input at rising edge of clk
        end
    end

endmodule