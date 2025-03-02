module TopModule (
    input  logic clk,       // Clock input, positive edge triggered
    input  logic reset,     // Synchronous active-high reset
    input  logic w,         // Input signal for state transition
    output logic z          // Output signal based on current state
);

    logic [2:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) 
            current_state <= 3'b000; // State A
        else 
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            3'b000: next_state = (w) ? 3'b001 : 3'b000; // A
            3'b001: next_state = (w) ? 3'b010 : 3'b011; // B
            3'b010: next_state = (w) ? 3'b100 : 3'b011; // C
            3'b011: next_state = (w) ? 3'b101 : 3'b000; // D
            3'b100: next_state = (w) ? 3'b100 : 3'b011; // E
            3'b101: next_state = (w) ? 3'b010 : 3'b011; // F
            default: next_state = 3'b000; // Default to state A
        endcase
    end

    always @(*) begin
        case (current_state)
            3'b100, 3'b101: z = 1'b1; // States E and F
            default: z = 1'b0;
        endcase
    end

endmodule