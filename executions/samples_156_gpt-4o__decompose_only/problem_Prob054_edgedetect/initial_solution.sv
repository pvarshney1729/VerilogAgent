module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    // Register to hold the previous state of the input
    logic [7:0] prev_in;

    // Sequential logic to update the previous state and detect positive edges
    always @(posedge clk) begin
        pedge <= ~prev_in & in; // Detect positive edge: 0 to 1 transition
        prev_in <= in;          // Update previous state
    end

endmodule