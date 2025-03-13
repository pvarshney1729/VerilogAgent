[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic x,
    output logic z
);

    typedef enum logic [2:0] {
        S000 = 3'b000,
        S001 = 3'b001,
        S010 = 3'b010,
        S011 = 3'b011,
        S100 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S000;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            S000: next_state = (x == 1'b0) ? S000 : S001;
            S001: next_state = (x == 1'b0) ? S001 : S100;
            S010: next_state = (x == 1'b0) ? S010 : S001;
            S011: next_state = (x == 1'b0) ? S001 : S010;
            S100: next_state = (x == 1'b0) ? S011 : S100;
            default: next_state = S000;
        endcase
    end

    assign z = (current_state == S011) || (current_state == S100);

endmodule
```
[DONE]