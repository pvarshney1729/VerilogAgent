module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    // Internal register to hold the previous state of the input
    logic [7:0] prev_in;

    // Sequential logic to detect positive edges
    always_ff @(posedge clk) begin
        // Iterate over each bit to detect positive edge
        for (int i = 0; i < 8; i++) begin
            // Check for 0 to 1 transition for each bit
            pedge[i] <= ~prev_in[i] & in[i];
        end
        // Update the previous input to the current input
        prev_in <= in;
    end

endmodule