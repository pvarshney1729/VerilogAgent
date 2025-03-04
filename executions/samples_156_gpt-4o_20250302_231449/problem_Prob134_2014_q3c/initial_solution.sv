```verilog
module TopModule (
    input logic clk,            // Clock signal
    input logic x,              // 1-bit control input
    input logic [2:0] y,        // 3-bit current state
    output logic Y0,            // 1-bit output representing Y[0] of the next state
    output logic z              // 1-bit output for FSM
);

    logic [2:0] next_state;

    always @(posedge clk) begin
        case (y)
            3'b000: begin
                if (x == 1'b0) begin
                    next_state <= 3'b000;
                end else begin
                    next_state <= 3'b001;
                end
                z <= 1'b0;
            end
            3'b001: begin
                if (x == 1'b0) begin
                    next_state <= 3'b001;
                end else begin
                    next_state <= 3'b100;
                end
                z <= 1'b0;
            end
            3'b010: begin
                if (x == 1'b0) begin
                    next_state <= 3'b010;
                end else begin
                    next_state <= 3'b001;
                end
                z <= 1'b0;
            end
            3'b011: begin
                if (x == 1'b0) begin
                    next_state <= 3'b001;
                end else begin
                    next_state <= 3'b010;
                end
                z <= 1'b1;
            end
            3'b100: begin
                if (x == 1'b0) begin
                    next_state <= 3'b011;
                end else begin
                    next_state <= 3'b100;
                end
                z <= 1'b1;
            end
            default: begin
                // Handle undefined states
                next_state <= 3'b000; // Default to a known state
                z <= 1'b0;
            end
        endcase
    end

    assign Y0 = next_state[0];

endmodule
```