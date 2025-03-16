```verilog
module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Active-high synchronous reset
    input logic in,        // Input signal
    output logic out       // Output signal, driven by state
);

    // State encoding using localparam for clarity
    localparam STATE_A = 1'b0; // State A with output out = 0
    localparam STATE_B = 1'b1; // State B with output out = 1

    // State registers
    logic current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset state
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                out = 1'b1;
                if (in == 1'b0) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_A: begin
                out = 1'b0;
                if (in == 1'b0) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_B;
                out = 1'b1;
            end
        endcase
    end

endmodule
```