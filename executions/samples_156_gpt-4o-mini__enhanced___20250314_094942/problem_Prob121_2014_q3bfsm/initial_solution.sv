module TopModule (
    input logic clk,           // Clock input, rising edge triggered
    input logic reset,         // Synchronous active-high reset
    input logic x,             // Input signal, single bit
    output logic z             // Output signal, single bit
);

    // State Declaration
    logic [2:0] y;             // Current state (3 bits)
    logic [2:0] next_y;        // Next state (3 bits)

    // State Encoding
    localparam STATE_000 = 3'b000;
    localparam STATE_001 = 3'b001;
    localparam STATE_010 = 3'b010;
    localparam STATE_011 = 3'b011;
    localparam STATE_100 = 3'b100;

    // FSM Timing Behavior
    always @(posedge clk) begin
        if (reset) begin
            y <= STATE_000;      // Reset state to 000
            z <= 1'b0;           // Output z is initialized to 0 on reset
        end else begin
            y <= next_y;         // Update current state to next state
        end
    end

    // Next State Logic
    always @(*) begin
        case (y)
            STATE_000: next_y = (x) ? STATE_001 : STATE_000; // Output z = 0
            STATE_001: next_y = (x) ? STATE_100 : STATE_001; // Output z = 0
            STATE_010: next_y = (x) ? STATE_001 : STATE_010; // Output z = 0
            STATE_011: next_y = (x) ? STATE_010 : STATE_001; // Output z = 1
            STATE_100: next_y = (x) ? STATE_100 : STATE_011; // Output z = 1
            default: next_y = STATE_000; // Default to reset state on invalid state
        endcase
    end

    // Output Logic
    always @(*) begin
        case (y)
            STATE_000: z = 1'b0;
            STATE_001: z = 1'b0;
            STATE_010: z = 1'b0;
            STATE_011: z = 1'b1;
            STATE_100: z = 1'b1;
            default: z = 1'b0; // Default output
        endcase
    end

endmodule