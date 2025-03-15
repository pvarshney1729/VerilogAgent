module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    // Register to hold the previous state of the input
    logic [7:0] prev_in;

    // Sequential logic to update previous state and detect positive edges
    always_ff @(posedge clk) begin
        // Detect positive edge for each bit
        pedge <= (~prev_in) & in;
        // Update previous state
        prev_in <= in;
    end

endmodule