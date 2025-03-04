module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= 3'b000;
        end else begin
            case (y)
                3'b000: next_state <= (x == 1'b0) ? 3'b000 : 3'b001;
                3'b001: next_state <= (x == 1'b0) ? 3'b001 : 3'b100;
                3'b010: next_state <= (x == 1'b0) ? 3'b010 : 3'b001;
                3'b011: next_state <= (x == 1'b0) ? 3'b001 : 3'b010;
                3'b100: next_state <= (x == 1'b0) ? 3'b011 : 3'b100;
                default: next_state <= 3'b000;
            endcase
        end
    end

    always_comb begin
        Y0 = next_state[0];
        case (y)
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule