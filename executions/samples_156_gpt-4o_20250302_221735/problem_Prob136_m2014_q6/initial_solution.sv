module TopModule (
    input logic clk,        // Clock input, triggers on positive edge
    input logic reset,      // Active-high reset input
    input logic w,          // Input signal w
    output logic z          // Output signal z
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

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b0) ? B : A;
            B: next_state = (w == 1'b0) ? C : D;
            C: next_state = (w == 1'b0) ? E : D;
            D: next_state = (w == 1'b0) ? F : A;
            E: next_state = (w == 1'b0) ? E : D;
            F: next_state = (w == 1'b0) ? C : D;
            default: next_state = A; // Handle undefined states
        endcase
    end

    // State register and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            z <= ((current_state == E) || (current_state == F)) ? 1'b1 : 1'b0;
        end
    end

endmodule