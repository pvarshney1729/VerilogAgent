```verilog
module TopModule (
    input wire clk,             // Clock input
    input wire rst,             // Synchronous reset input
    input wire [2:0] y,         // 3-bit input, y[2] is MSB
    input wire x,               // 1-bit input
    output reg Y0,              // 1-bit output, corresponds to next state's LSB
    output reg z                // 1-bit output
);

    reg [2:0] state;            // Current state

    always @(posedge clk) begin
        if (rst) begin
            state <= 3'b000;
        end else begin
            case (y)
                3'b000: state <= (x ? 3'b001 : 3'b000);
                3'b001: state <= (x ? 3'b100 : 3'b001);
                3'b010: state <= (x ? 3'b001 : 3'b010);
                3'b011: state <= (x ? 3'b010 : 3'b001);
                3'b100: state <= (x ? 3'b100 : 3'b011);
                default: state <= 3'b000;
            endcase
        end
    end

    always @(*) begin
        case (y)
            3'b000, 3'b001, 3'b010: z = 0;
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
        Y0 = state[0];
    end

endmodule
```