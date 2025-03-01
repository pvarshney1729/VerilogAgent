module TopModule (
    input logic clk,       // Clock input, positive edge triggered, 1-bit wide
    input logic areset,    // Asynchronous active-high reset input, 1-bit wide
    input logic in,        // State machine input, 1-bit wide
    output logic out       // State machine output, 1-bit wide, registered
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
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Handle undefined states
        endcase
    end

    // State register and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            case (next_state)
                A: out <= 1'b0;
                B: out <= 1'b0;
                C: out <= 1'b0;
                D: out <= 1'b1;
                default: out <= 1'b0; // Default output for safety
            endcase
        end
    end

endmodule