module TopModule(
    input logic clk,      // Clock signal, positive-edge triggered
    input logic reset,    // Synchronous active-high reset
    input logic w,        // Input signal w, 1-bit
    output logic z        // Output signal z, 1-bit
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state, next_state; // State registers

    always @(posedge clk) begin
        if (reset) begin
            state <= A;      // Reset to state A
            z <= 0;          // Ensure z is reset to 0
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default state
        endcase
    end

    always @(*) begin
        case(state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule