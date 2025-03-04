module TopModule(
    input logic clk,         // Clock signal; positive edge-triggered
    input logic reset,       // Active-high synchronous reset
    input logic w,           // Input signal 'w'
    output logic z           // Output signal 'z'
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State Register
    always @(posedge clk) begin
        if (reset)
            current_state <= A; // State A
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default to state A
        endcase
    end

    // Output Logic
    always @(*) begin
        case (current_state)
            E, F: z = 1; // States E and F
            default: z = 0;
        endcase
    end

endmodule