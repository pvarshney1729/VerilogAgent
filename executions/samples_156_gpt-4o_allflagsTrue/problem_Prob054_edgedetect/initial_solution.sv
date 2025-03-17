module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= ~prev_in & in; // Detect 0 to 1 transition
        prev_in <= in;          // Update previous state
    end

endmodule