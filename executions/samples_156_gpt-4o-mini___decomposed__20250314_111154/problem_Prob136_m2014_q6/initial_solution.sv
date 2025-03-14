module TopModule (
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

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b0) ? B : A; // A
            B: next_state = (w == 1'b0) ? C : D; // B
            C: next_state = (w == 1'b0) ? E : D; // C
            D: next_state = (w == 1'b0) ? F : A; // D
            E: next_state = (w == 1'b0) ? E : D; // E
            F: next_state = (w == 1'b0) ? C : D; // F
            default: next_state = A; // Default to state A
        endcase
    end

    always @(*) begin
        z = (current_state == E || current_state == F) ? 1'b1 : 1'b0; // Output logic
    end
endmodule