module TopModule (
    input  wire        clk,     // Clock signal, positive edge-triggered
    input  wire        areset,  // Asynchronous reset, active high
    input  wire [7:0]  d,       // 8-bit data input, unsigned
    output reg  [7:0]  q        // 8-bit data output, unsigned
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000;
        end else begin
            q <= d;
        end
    end

endmodule