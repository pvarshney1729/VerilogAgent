module TopModule (
    input logic [2:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1
);

    // State encoding
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
            default: next_state = A;
        endcase
    end

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (rst) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign Y1 = current_state[1];

endmodule