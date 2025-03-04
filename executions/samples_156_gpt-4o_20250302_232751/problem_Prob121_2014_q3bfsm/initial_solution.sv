module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic reset,      // Synchronous active high reset
    input logic x,          // Input signal
    output logic z          // Output signal, combinationally determined by the state
);

// Internal state representation
logic [2:0] state; // State register, y[2:0]

// Initial Block
// Initial state configuration
initial begin
    state = 3'b000; // Initial state set to 000 on power-up
    z = 1'b0;       // Initial output set to 0
end

// Synchronous Reset Behavior
// On reset, set the state to 000 regardless of input x
always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset state
    end else begin
        // State Transition Logic
        case (state)
            3'b000: state <= (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: state <= (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: state <= (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: state <= (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: state <= (x == 1'b0) ? 3'b011 : 3'b100;
            default: state <= 3'b000; // Default state for undefined states
        endcase
    end
end

// Output Logic
always @(*) begin
    case (state)
        3'b011, 3'b100: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule