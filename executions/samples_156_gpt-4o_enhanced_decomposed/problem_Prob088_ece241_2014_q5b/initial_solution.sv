module TopModule(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding using one-hot
    logic state_A, state_B;

    // State transition and output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to state A
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            // State transitions
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                end
                2'b01: begin // State B
                    // Remain in state B regardless of x
                    state_A <= 1'b0;
                    state_B <= 1'b1;
                end
                default: begin
                    // Default to state A in case of invalid state
                    state_A <= 1'b1;
                    state_B <= 1'b0;
                end
            endcase
        end
    end

    // Output logic based on current state and input x
    always_comb begin
        case ({state_A, state_B})
            2'b10: z = x;      // State A: z = x
            2'b01: z = ~x;     // State B: z = ~x
            default: z = 1'b0; // Default output
        endcase
    end

endmodule