```verilog
module TopModule (
    input wire in,               // 1-bit input signal
    input wire [1:0] state,      // 2-bit current state input
    output reg [1:0] next_state, // 2-bit next state output
    output reg out               // 1-bit output signal
);

always @(*) begin
    case (state)
        2'b00: begin // State A
            next_state = (in == 1'b0) ? 2'b00 : 2'b01;
            out = 1'b0;
        end
        2'b01: begin // State B
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b0;
        end
        2'b10: begin // State C
            next_state = (in == 1'b0) ? 2'b00 : 2'b11;
            out = 1'b0;
        end
        2'b11: begin // State D
            next_state = (in == 1'b0) ? 2'b10 : 2'b01;
            out = 1'b1;
        end
        default: begin
            next_state = 2'b00; // Default to state A on invalid state input
            out = 1'b0;
        end
    endcase
end

endmodule
```