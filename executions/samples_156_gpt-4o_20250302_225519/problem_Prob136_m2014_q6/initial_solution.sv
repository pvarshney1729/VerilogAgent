module TopModule (
    input logic clk,         // Clock input, positive edge triggered
    input logic reset,       // Reset input, synchronous, active high
    input logic w,           // Input signal
    output logic z           // Output signal, driven by state
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            case (current_state)
                A: current_state <= (w) ? A : B;
                B: current_state <= (w) ? D : C;
                C: current_state <= (w) ? D : E;
                D: current_state <= (w) ? A : F;
                E: current_state <= (w) ? D : E;
                F: current_state <= (w) ? D : C;
                default: current_state <= A;
            endcase
        end
    end

    always_comb begin
        case (current_state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule