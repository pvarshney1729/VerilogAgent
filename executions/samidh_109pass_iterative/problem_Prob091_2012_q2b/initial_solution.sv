module TopModule (
    input logic [5:0] y,      // 6-bit one-hot encoded current state input
    input logic w,            // 1-bit input signal
    input logic clk,          // Clock signal
    input logic reset,        // Synchronous reset signal
    output logic Y1,          // 1-bit output derived from next state logic
    output logic Y3           // 1-bit output derived from next state logic
);

    // State encoding
    typedef enum logic [5:0] {
        A = 6'b000001,
        B = 6'b000010,
        C = 6'b000100,
        D = 6'b001000,
        E = 6'b010000,
        F = 6'b100000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Handle invalid states
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign Y1 = (next_state == B) ? 1'b1 : 1'b0;
    assign Y3 = (next_state == D) ? 1'b1 : 1'b0;

endmodule