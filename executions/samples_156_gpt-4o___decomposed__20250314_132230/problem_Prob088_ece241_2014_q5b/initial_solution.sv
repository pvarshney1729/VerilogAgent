module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding using one-hot
    logic state_A, state_B;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_A <= 1'b1;
            state_B <= 1'b0;
        end else begin
            case (1'b1) // One-hot encoded current state
                state_A: begin
                    if (x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                end
                state_B: begin
                    if (~x) begin
                        state_A <= 1'b0;
                        state_B <= 1'b1;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (1'b1) // One-hot encoding for output logic
            state_A: z = x ? 1'b1 : 1'b0;
            state_B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0; // default case for safety
        endcase
    end

endmodule