module TopModule (
    input logic clk,      // 1-bit clock input, positive edge-triggered
    input logic areset,   // 1-bit asynchronous reset input, active high
    input logic in,       // 1-bit data input
    output logic out      // 1-bit data output
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset behavior
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
            out <= 0;
        end else begin
            current_state <= next_state;
            out <= (current_state == D) ? 1 : 0; // Output logic based on state
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
            default: next_state = A; // Default to state A
        endcase
    end

endmodule