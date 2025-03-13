```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    logic [2:0] state, next_state;

    // State transition logic with synchronous reset
    always @(posedge clk) begin
        if (y == 3'b000) begin // Example condition for reset
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = state; // Default to stay in the current state
        z = 1'b0;           // Default output value
        case (state)
            3'b000: begin
                next_state = x ? 3'b001 : 3'b000;
                z = 1'b0;
            end
            3'b001: begin
                next_state = x ? 3'b100 : 3'b001;
                z = 1'b0;
            end
            3'b010: begin
                next_state = x ? 3'b001 : 3'b010;
                z = 1'b0;
            end
            3'b011: begin
                next_state = x ? 3'b010 : 3'b001;
                z = 1'b1;
            end
            3'b100: begin
                next_state = x ? 3'b100 : 3'b011;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000; // Default safe state
                z = 1'b0;
            end
        endcase
        Y0 = next_state[0];
    end
endmodule
[DONE]
```