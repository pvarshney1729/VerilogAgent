module TopModule (
    input logic clk,       // Clock input for sequential logic
    input logic L,         // Load control signal (active high)
    input logic q_in,      // Input to the flip-flop
    input logic r_in,      // Input to the multiplexer
    output logic Q         // Output of the flip-flop
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule