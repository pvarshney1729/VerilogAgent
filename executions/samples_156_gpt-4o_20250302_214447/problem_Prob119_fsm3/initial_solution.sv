module TopModule (
    input  logic clk,       // Clock signal, positive edge-triggered
    input  logic areset,    // Asynchronous reset signal, active high
    input  logic in,        // Input signal, unsigned, 1-bit
    output logic out        // Output signal, unsigned, 1-bit
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end

    // State register and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
            out <= 0;
        end else begin
            current_state <= next_state;
            case (current_state)
                A, B, C: out <= 0;
                D: out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule