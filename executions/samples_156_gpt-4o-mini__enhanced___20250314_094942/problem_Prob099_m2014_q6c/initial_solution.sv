module TopModule (
    input  logic [5:0] y,    // One-hot encoded state representation
    input  logic w,          // 1-bit input signal
    output logic Y1,         // 1-bit output signal
    output logic Y2,         // 1-bit output signal derived from y[1]
    output logic Y3          // 1-bit output signal derived from y[3]
);

    // State Definitions (one-hot encoding as per the specification)
    localparam A = 6'b000001; // State A
    localparam B = 6'b000010; // State B
    localparam C = 6'b000100; // State C
    localparam D = 6'b001000; // State D
    localparam E = 6'b010000; // State E
    localparam F = 6'b100000; // State F

    logic [5:0] state;         // Current state register
    logic [5:0] next_state;    // Next state register
    logic clk;                 // Clock signal
    logic reset;               // Reset signal

    // Reset Behavior
    always @(posedge clk) begin
        if (!reset) begin
            state <= A;      // Reset state to A
        end else begin
            state <= next_state; // Update current state
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            A: next_state = (w == 0) ? B : A;
            B: next_state = (w == 0) ? C : D;
            C: next_state = (w == 0) ? E : D;
            D: next_state = (w == 0) ? F : A;
            E: next_state = (w == 0) ? E : D;
            F: next_state = (w == 0) ? C : D;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Output Logic
    assign Y1 = (state == E); // Example output logic for Y1
    assign Y2 = y[1];         // Direct mapping from y[1]
    assign Y3 = y[3];         // Direct mapping from y[3]

endmodule