module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

logic [7:0] in_d; // Delay register to hold the previous state

always @(posedge clk) begin
    in_d <= in; // Store the current input for the next cycle
end

assign pedge = (~in_d & in); // Detect 0 to 1 transitions

endmodule