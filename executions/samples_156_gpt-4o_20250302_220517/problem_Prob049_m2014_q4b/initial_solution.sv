module TopModule (
    input logic clk,         // 1-bit clock input, positive edge triggered
    input logic ar,          // 1-bit asynchronous reset input, active high
    input logic d,           // 1-bit data input
    output logic q           // 1-bit output
);

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Reset output to 0 on active high reset
        end else begin
            q <= d;    // Sample and store data input on rising edge of clock
        end
    end

endmodule