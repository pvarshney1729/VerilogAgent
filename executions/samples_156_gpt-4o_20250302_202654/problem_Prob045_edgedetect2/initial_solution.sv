module TopModule (
    input logic clk,          // 1-bit clock input, positive edge triggered
    input logic arst_n,       // Asynchronous active-low reset
    input logic [7:0] in,     // 8-bit input vector
    output logic [7:0] anyedge // 8-bit output vector
);

    logic [7:0] prev_in; // Register to store the previous state of `in`

    always_ff @(posedge clk or negedge arst_n) begin
        if (!arst_n) begin
            anyedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            anyedge <= in ^ prev_in; // XOR to detect any edge
            prev_in <= in;           // Update previous state
        end
    end

endmodule