```verilog
module TopModule (
    input logic clk,
    input logic areset, // Asynchronous active-high reset
    input logic x,
    output logic z
);

    logic [1:0] state, next_state;

    // State encoding
    localparam logic [1:0] A = 2'b01;
    localparam logic [1:0] B = 2'b10;

    // Asynchronous reset and state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 1'b0;
        end else begin
            state <= next_state;
            z <= (state == A) ? x : ~x;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = (x == 1'b1) ? B : A;
            B: next_state = B;
            default: next_state = A; // Default safety
        endcase
    end

endmodule
```