module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic rst_n,          // Asynchronous active-low reset
    input logic [7:0] in,       // 8-bit unsigned input vector
    output logic [7:0] anyedge  // 8-bit output vector detecting any edge
);

logic [7:0] prev_in;  // Internal register to hold the previous state of 'in'

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        prev_in <= 8'd0;
        anyedge <= 8'd0;
    end else begin
        anyedge <= (in ^ prev_in);  // XOR to detect any change
        prev_in <= in;
    end
end

endmodule