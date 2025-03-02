module state_machine (
    input logic clk,
    input logic rst_n,
    input logic a,
    output logic [2:0] q
);

    logic [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = a ? 3'b001 : 3'b000;
            3'b001: next_state = a ? 3'b010 : 3'b000;
            3'b010: next_state = a ? 3'b011 : 3'b000;
            3'b011: next_state = a ? 3'b100 : 3'b000;
            3'b100: next_state = a ? 3'b000 : 3'b000; // wrap-around
            default: next_state = 3'b000;
        endcase
    end

    // Synchronous reset and state update
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 3'b000; // reset state
        end else begin
            state <= next_state;
        end
    end

    // Output assignment
    assign q = state;

endmodule