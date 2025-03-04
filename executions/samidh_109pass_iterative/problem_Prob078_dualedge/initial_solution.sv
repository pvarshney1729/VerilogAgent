module TopModule (
    input logic clk,  // 1-bit clock input
    input logic d,    // 1-bit data input
    output logic q    // 1-bit data output
);

    logic d_posedge;  // Intermediate register for rising edge

    always @(posedge clk) begin
        d_posedge <= d;  // Capture input on rising edge
    end

    always @(negedge clk) begin
        q <= d_posedge;  // Transfer captured value on falling edge
    end

endmodule