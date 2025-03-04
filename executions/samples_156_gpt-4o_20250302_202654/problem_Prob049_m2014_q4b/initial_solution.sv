module TopModule (
    input  wire clk,   // Clock signal, positive edge triggered
    input  wire ar,    // Asynchronous reset, active high
    input  wire d,     // Data input
    output reg  q      // Data output
);

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule