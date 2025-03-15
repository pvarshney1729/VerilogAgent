module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    // Register to hold the previous state of the input
    logic [7:0] prev_in;

    // Sequential logic to update previous state and detect edges
    always_ff @(posedge clk) begin
        // Detect any edge for each bit
        anyedge <= in ^ prev_in;
        // Update previous state
        prev_in <= in;
    end

endmodule