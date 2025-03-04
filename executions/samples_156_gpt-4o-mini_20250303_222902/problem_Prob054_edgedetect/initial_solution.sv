module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic [7:0] in,        // 8-bit input vector, unsigned
    output logic [7:0] pedge      // 8-bit output vector, unsigned
);
    logic [7:0] prev_in;         // Internal register to hold previous state of in

    always @(posedge clk) begin
        pedge <= (in & ~prev_in); // Detect positive edges
        prev_in <= in;            // Update previous state
    end
endmodule