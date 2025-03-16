[BEGIN]
module TopModule (
    input logic clk,  // Clock signal, positive-edge triggered
    input logic in,   // Input signal, 1-bit, unsigned
    output logic out  // Output signal, 1-bit, unsigned
);

    logic q; // Internal D flip-flop state

    assign out = q;

    always @(posedge clk) begin
        q <= in ^ q; // XOR operation with feedback from current q
    end

endmodule
[DONE]