module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        anyedge <= in ^ prev_in; // Detect any edge by XORing current and previous input
        prev_in <= in;           // Update previous input state
    end

endmodule