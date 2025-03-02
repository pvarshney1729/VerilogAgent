```verilog
module state_machine (
    input logic clk,
    input logic rst,
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

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (rst) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = F;
            F: next_state = A;
            default: next_state = A;
        endcase
    end

    // Output logic
    assign z = (current_state == E) || (current_state == F);

endmodule
```