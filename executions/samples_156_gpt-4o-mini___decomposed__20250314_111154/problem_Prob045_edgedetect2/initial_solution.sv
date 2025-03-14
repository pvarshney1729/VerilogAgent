module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);
    logic [7:0] prev_state; // Register to hold the previous state of 'in'

    always @(posedge clk) begin
        anyedge <= (in ^ prev_state); // Detect edge by XORing current and previous input
        prev_state <= in; // Update previous input state
    end
endmodule