module fsm (
    input logic clk,
    input logic rst_n,
    input logic input_signal,
    output logic output_signal
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

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = input_signal ? B : A;
            B: next_state = input_signal ? C : A;
            C: next_state = input_signal ? D : A;
            D: next_state = input_signal ? E : A;
            E: next_state = input_signal ? F : A;
            F: next_state = input_signal ? A : A;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        output_signal = (current_state == F);
    end

endmodule