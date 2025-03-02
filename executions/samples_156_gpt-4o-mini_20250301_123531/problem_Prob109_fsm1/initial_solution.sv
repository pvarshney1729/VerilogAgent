module TopModule (
    input  logic clk,      // Clock signal
    input  logic areset,   // Asynchronous reset signal, active high
    input  logic in,       // Input signal for state transitions
    output logic out       // Output signal, 1 bit
);

    typedef enum logic {A, B} state_t;
    state_t state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            case (state)
                A: state <= (in == 0) ? B : A;
                B: state <= (in == 0) ? A : B;
                default: state <= A; // Default to A in case of an invalid state
            endcase
        end
    end

    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 0; // Default output for safety
        endcase
    end

endmodule