```verilog
[BEGIN]
module TopModule(
    input logic in,               // 1-bit input signal
    input logic [1:0] state,      // 2-bit current state input, unsigned
    output logic [1:0] next_state, // 2-bit next state output, unsigned
    output logic out              // 1-bit output signal
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
        default: begin // Handling invalid states
            next_state = 2'b00;
            out = 1'b0;
        end
    endcase
end

endmodule
[DONE]
```