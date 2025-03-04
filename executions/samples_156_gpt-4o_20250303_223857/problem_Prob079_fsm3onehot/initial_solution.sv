```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= 4'b0001; // State A
        end else begin
            case (state)
                4'b0001: // State A
                    next_state <= (in == 1'b0) ? 4'b0001 : 4'b0010;
                4'b0010: // State B
                    next_state <= (in == 1'b0) ? 4'b0100 : 4'b0010;
                4'b0100: // State C
                    next_state <= (in == 1'b0) ? 4'b0001 : 4'b1000;
                4'b1000: // State D
                    next_state <= (in == 1'b0) ? 4'b0100 : 4'b0010;
                default: // Undefined states
                    next_state <= 4'b0001; // Transition to State A
            endcase
        end
    end

    always_comb begin
        case (state)
            4'b1000: // State D
                out = 1'b1;
            default:
                out = 1'b0;
        endcase
    end

endmodule
```