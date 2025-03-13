[BEGIN]
module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

logic d_rise, d_fall;

always @(posedge clk) begin
    d_rise <= d; // Capture on rising edge
end

always @(negedge clk) begin
    d_fall <= d; // Capture on falling edge
end

always @(*) begin
    q = d_rise | d_fall; // Combine the captured values
end

endmodule
[DONE]