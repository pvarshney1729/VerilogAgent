module TopModule (
    input logic clk,            // Clock input for sequential logic
    input logic L,              // Load enable signal
    input logic q_in,           // Data input for the flip-flop
    input logic r_in,           // Input to multiplexer from 'r'
    output logic Q              // Output from the flip-flop
);

    logic mux_out;

    // Multiplexer logic
    always @(*) begin
        if (L) 
            mux_out = r_in;
        else 
            mux_out = q_in;
    end

    // Flip-flop logic
    always_ff @(posedge clk) begin
        Q <= mux_out;
    end

endmodule