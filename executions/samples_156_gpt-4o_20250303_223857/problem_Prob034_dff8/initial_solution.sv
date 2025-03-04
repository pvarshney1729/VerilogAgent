module TopModule (
    input wire clk,
    input wire reset_n,
    input wire [7:0] d,
    output reg [7:0] q
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 8'b00000000; // Reset state
        else
            q <= d; // Capture input on rising edge of clk
    end

endmodule