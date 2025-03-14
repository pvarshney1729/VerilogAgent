[BEGIN]
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);
    logic [7:0] in_prev;

    always @(posedge clk) begin
        anyedge <= (in_prev ^ in); // Detect edges
        in_prev <= in; // Update previous state
    end
endmodule
[DONE]