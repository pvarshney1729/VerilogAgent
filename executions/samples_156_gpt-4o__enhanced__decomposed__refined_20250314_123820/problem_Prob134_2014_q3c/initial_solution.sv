[BEGIN]
module TopModule (
    input logic clk,
    input logic rst,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    // Next state logic
    always_ff @(posedge clk) begin
        if (rst) begin
            next_state <= 3'b000; // Synchronous reset to state 000
        end else begin
            case (y)
                3'b000: next_state <= x ? 3'b001 : 3'b000;
                3'b001: next_state <= x ? 3'b100 : 3'b001;
                3'b010: next_state <= x ? 3'b001 : 3'b010;
                3'b011: next_state <= x ? 3'b010 : 3'b001;
                3'b100: next_state <= x ? 3'b100 : 3'b011;
                default: next_state <= 3'b000; // Handle undefined states
            endcase
        end
    end

    // Output logic for z
    always_comb begin
        case (y)
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // Output logic for Y0
    always_comb begin
        Y0 = next_state[0];
    end

endmodule
[DONE]