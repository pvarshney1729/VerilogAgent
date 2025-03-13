```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    logic [1:0] state, next_state;
    localparam state_A = 2'b01, state_B = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= state_A;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            state_A: begin
                if (x == 1'b1) begin
                    next_state = state_B;
                    z = 1'b1;
                end else begin
                    next_state = state_A;
                    z = 1'b0;
                end
            end
            state_B: begin
                if (x == 1'b1) begin
                    next_state = state_B;
                    z = 1'b0;
                end else begin
                    next_state = state_B;
                    z = 1'b1;
                end
            end
            default: begin
                next_state = state_A;
                z = 1'b0;
            end
        endcase
    end
endmodule
[DONE]
```