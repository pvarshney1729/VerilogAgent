[BEGIN]
module TopModule(
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // Synchronous reset to state 000
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000; // default reset state for unlisted states
        endcase
    end

    // Output logic
    always @(*) begin
        z = (state == 3'b011 || state == 3'b100) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]