```verilog
module TopModule(
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        // State transition logic
        case (state)
            4'b0001: begin // State A
                if (in == 1'b0) begin
                    next_state = 4'b0001; // Remain in A
                end else begin
                    next_state = 4'b0010; // Transition to B
                end
            end
            4'b0010: begin // State B
                if (in == 1'b0) begin
                    next_state = 4'b0100; // Transition to C
                end else begin
                    next_state = 4'b0010; // Remain in B
                end
            end
            4'b0100: begin // State C
                if (in == 1'b0) begin
                    next_state = 4'b0001; // Transition to A
                end else begin
                    next_state = 4'b1000; // Transition to D
                end
            end
            4'b1000: begin // State D
                if (in == 1'b0) begin
                    next_state = 4'b0100; // Transition to C
                end else begin
                    next_state = 4'b0010; // Transition to B
                end
                out = 1'b1; // Output 1 in state D
            end
            default: begin
                // Handle invalid state if necessary
                next_state = 4'b0001; // Default to state A
            end
        endcase
    end

endmodule
```