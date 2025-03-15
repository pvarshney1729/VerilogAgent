module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic x,
    output logic z
);

    // State encoding using one-hot
    logic state_A, state_B;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to state A
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            // State transition logic
            case ({state_A, state_B})
                2'b10: begin // State A
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                    // Output logic for state A
                    z <= x;
                end
                2'b01: begin // State B
                    // State B remains the same regardless of x
                    // Output logic for state B
                    z <= ~x;
                end
                default: begin
                    // Default to state A in case of unexpected state
                    state_A <= 1'b1;
                    state_B <= 1'b0;
                end
            endcase
        end
    end

endmodule