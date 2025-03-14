[BEGIN]
module TopModule (
    input logic clk,       // Clock input
    input logic reset,     // Synchronous active-high reset
    input logic x,         // Input signal
    output logic z         // Output signal
);

    logic [2:0] y;  // 3-bit state register

    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;  // Reset state
        end else begin
            case (y)
                3'b000: y <= x ? 3'b001 : 3'b000;
                3'b001: y <= x ? 3'b100 : 3'b001;
                3'b010: y <= x ? 3'b001 : 3'b010;
                3'b011: y <= x ? 3'b010 : 3'b001;
                3'b100: y <= x ? 3'b100 : 3'b011;
                default: y <= 3'b000;  // Fallback to reset state
            endcase
        end
    end

    always_comb begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 1'b0;
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
[DONE]