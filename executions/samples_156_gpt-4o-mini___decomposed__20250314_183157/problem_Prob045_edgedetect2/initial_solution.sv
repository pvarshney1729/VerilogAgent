module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);
    logic [7:0] in_d; // Delayed version of input

    always @(posedge clk) begin
        anyedge <= (in ^ in_d); // Detect changes
        in_d <= in; // Update delayed input
    end
endmodule