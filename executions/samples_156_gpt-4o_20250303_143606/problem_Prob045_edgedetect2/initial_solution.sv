module TopModule (
    input logic clk,          // Clock input, 1 bit
    input logic [7:0] in,     // 8-bit input vector
    output logic [7:0] anyedge // 8-bit output vector
);

    logic [7:0] prev_in; // Register to store the previous state of `in`

    always_ff @(posedge clk) begin
        anyedge <= in ^ prev_in; // Detect edges by XORing current and previous states
        prev_in <= in;           // Update previous state
    end

endmodule