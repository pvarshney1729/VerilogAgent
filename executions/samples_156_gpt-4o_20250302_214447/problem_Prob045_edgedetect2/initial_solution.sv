module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic reset_n,         // Synchronous reset signal, active low
    input logic [7:0] in,        // 8-bit input vector, unsigned
    output logic [7:0] anyedge   // 8-bit output vector, representing edge detection result
);

    logic [7:0] prev_in; // Register to hold the previous state of the input

    always @(posedge clk) begin
        if (!reset_n) begin
            prev_in <= 8'b0;
            anyedge <= 8'b0;
        end else begin
            anyedge <= (in ^ prev_in); // XOR to detect change
            prev_in <= in;             // Update previous input state
        end
    end
endmodule