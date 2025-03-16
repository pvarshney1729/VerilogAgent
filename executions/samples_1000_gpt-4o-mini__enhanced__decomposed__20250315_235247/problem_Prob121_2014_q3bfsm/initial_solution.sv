module TopModule(
    input clk,
    input reset,
    input x,
    output reg z
);
    logic [2:0] y; // Current state

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000; // Reset to state 000
        end else begin
            case (y)
                3'b000: y <= (x == 1'b0) ? 3'b000 : 3'b001;
                3'b001: y <= (x == 1'b0) ? 3'b001 : 3'b100;
                3'b010: y <= (x == 1'b0) ? 3'b010 : 3'b001;
                3'b011: y <= (x == 1'b0) ? 3'b001 : 3'b010;
                3'b100: y <= (x == 1'b0) ? 3'b011 : 3'b100;
                default: y <= 3'b000; // Default case to handle unexpected states
            endcase
        end
    end

    // Output logic based on current state
    always @(*) begin
        case (y)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b1;
            3'b100: z = 1'b1;
            default: z = 1'b0; // Default case to handle unexpected states
        endcase
    end
endmodule