```
[BEGIN]
module TopModule (
    input  logic clk,
    input  logic x,
    input  logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;
    logic [2:0] current_state;

    // Synchronous reset and state update
    always @(posedge clk) begin
        current_state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default values
        next_state = current_state; // retain current state by default
        z = 1'b0; // default output

        case (current_state)
            3'b000: begin
                next_state = (x) ? 3'b001 : 3'b000;
            end
            3'b001: begin
                next_state = (x) ? 3'b100 : 3'b001;
            end
            3'b010: begin
                next_state = (x) ? 3'b001 : 3'b010;
            end
            3'b011: begin
                next_state = (x) ? 3'b010 : 3'b001;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x) ? 3'b100 : 3'b011;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000;
            end
        endcase
    end

    assign Y0 = next_state[0];

endmodule
[DONE]
```