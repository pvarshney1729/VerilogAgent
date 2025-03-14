[BEGIN]
```verilog
module TopModule (
    input logic clk,           // Clock input, 1 bit
    input logic reset,         // Synchronous active high reset, 1 bit
    input logic in,           // Input signal, 1 bit
    output logic out          // Output signal, 1 bit
);

    localparam STATE_A = 2'b00;
    localparam STATE_B = 2'b01;
    localparam STATE_C = 2'b10;
    localparam STATE_D = 2'b11;

    logic [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A; // Reset to state A
            out <= 1'b0;               // Output is 0 in state A
        end else begin
            current_state <= next_state; // Update state
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                next_state = (in) ? STATE_B : STATE_A;
                out = 1'b0; // Output is 0
            end
            STATE_B: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b0; // Output is 0
            end
            STATE_C: begin
                next_state = (in) ? STATE_D : STATE_A;
                out = 1'b0; // Output is 0
            end
            STATE_D: begin
                next_state = (in) ? STATE_B : STATE_C;
                out = 1'b1; // Output is 1
            end
            default: begin
                next_state = STATE_A; // default case for safety
                out = 1'b0; // Safety output
            end
        endcase
    end

endmodule
```
[DONE]