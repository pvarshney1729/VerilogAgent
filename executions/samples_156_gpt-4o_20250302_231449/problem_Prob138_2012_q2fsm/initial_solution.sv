module TopModule(
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
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
            A: next_state = (w == 1) ? B : A;
            B: next_state = (w == 1) ? C : D;
            C: next_state = (w == 1) ? E : D;
            D: next_state = (w == 1) ? F : A;
            E: next_state = (w == 1) ? E : D;
            F: next_state = (w == 1) ? C : D;
            default: next_state = A;
        endcase
    end

    // State register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule