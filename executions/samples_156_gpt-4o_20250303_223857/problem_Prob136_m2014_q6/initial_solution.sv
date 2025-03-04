```verilog
module TopModule (
    input  logic clk,     // Clock signal, positive edge-triggered
    input  logic reset,   // Reset signal, active-high, synchronous
    input  logic w,       // State transition input
    output logic z        // Output signal
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t state;

    always @(posedge clk) begin
        if (reset) begin
            state <= A; // Initial state A
        end else begin
            case (state)
                A: state <= (w == 0) ? B : A;
                B: state <= (w == 0) ? C : D;
                C: state <= (w == 0) ? E : D;
                D: state <= (w == 0) ? F : A;
                E: state <= (w == 0) ? E : D;
                F: state <= (w == 0) ? C : D;
                default: state <= A; // Default recovery to state A
            endcase
        end
    end

    always @(*) begin
        case (state)
            E, F: z = 1; // States E and F
            default: z = 0;
        endcase
    end

endmodule
```