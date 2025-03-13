[BEGIN]
module TopModule (
    input logic in1,   // Input signal 1 (1-bit)
    input logic in2,   // Input signal 2 (1-bit)
    output logic out   // Output signal (1-bit)
);

always @(*) begin
    out = ~(in1 | in2); // Implementing the 2-input NOR gate
end

endmodule
[DONE]