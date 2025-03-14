module TopModule (
    input logic clk,         // Clock signal (1-bit input)
    input logic x,           // Input signal (1-bit input)
    output logic z           // Output signal (1-bit output)
);

    // Internal Signals
    logic ff_xor;             // Output of XOR gate D flip-flop
    logic ff_and;             // Output of AND gate D flip-flop
    logic ff_or;              // Output of OR gate D flip-flop

    // Finite State Machine (FSM) Logic
    always @(posedge clk) begin
        ff_xor <= (x ^ ff_xor);  // XOR gate operation
        ff_and <= (x & ~ff_and); // AND gate operation with complemented output
        ff_or  <= (x | ~ff_or);   // OR gate operation with complemented output
    end

    // Output Logic
    assign z = ~(ff_xor | ff_and | ff_or); // Three-input NOR gate to output z

endmodule