module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic [2:0] y;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
        end else begin
            case (y)
                3'b000: y <= (x) ? 3'b001 : 3'b000;
                3'b001: y <= (x) ? 3'b100 : 3'b001;
                3'b010: y <= (x) ? 3'b001 : 3'b010;
                3'b011: y <= (x) ? 3'b010 : 3'b001;
                3'b100: y <= (x) ? 3'b100 : 3'b011;
                default: y <= 3'b000; // Handle illegal states
            endcase
        end
    end

    // Output logic
    always_comb begin
        case (y)
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
    end

endmodule