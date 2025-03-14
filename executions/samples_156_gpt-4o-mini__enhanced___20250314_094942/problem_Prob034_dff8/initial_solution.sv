module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic [7:0] d,      // Input data (8 bits), unsigned
    output logic [7:0] q       // Output data (8 bits), unsigned
);

    // Initial state of flip-flops
    initial begin
        q = 8'b00000000;        // Initial state of output register q
    end

    // Behavior description
    // On the positive edge of the clock, the output q will take the value of input d
    always @(posedge clk) begin
        q <= d;                 // Capture input d into output q
    end

endmodule