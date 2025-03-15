module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    // State register for the flip-flop
    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;  // Load r_in when L is asserted
        end else begin
            Q <= q_in;  // Retain the current state when L is not asserted
        end
    end

    // Initial value for simulation
    initial begin
        Q = 1'b0;  // Initialize Q to 0
    end

endmodule