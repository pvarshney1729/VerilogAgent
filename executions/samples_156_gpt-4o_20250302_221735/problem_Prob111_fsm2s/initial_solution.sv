module TopModule (
    input  logic clk,    // Clock signal; active on rising edge
    input  logic reset,  // Synchronous active-high reset
    input  logic j,      // Input signal j; unsigned, single-bit
    input  logic k,      // Input signal k; unsigned, single-bit
    output logic out     // Output signal out; unsigned, single-bit
);

    // State encoding
    localparam logic OFF = 1'b0;
    localparam logic ON  = 1'b1;

    // State register
    logic state;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= OFF; // Initialize to OFF state
        end else begin
            case (state)
                OFF: if (j) state <= ON; // Transition to ON if j is 1
                ON:  if (k) state <= OFF; // Transition to OFF if k is 1
            endcase
        end
    end

    // Output logic
    always_comb begin
        out = state; // Output reflects the current state
    end

endmodule