```verilog
module TopModule (
    input logic clk,         // Clock input, positive edge-triggered
    input logic areset,      // Asynchronous reset, active high
    input logic j,           // Input signal j
    input logic k,           // Input signal k
    output logic out         // Output signal out
);

    // State Definitions
    parameter logic OFF = 1'b0;
    parameter logic ON = 1'b1;

    // Current state of the state machine
    logic state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end else begin
                        state <= OFF;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end else begin
                        state <= ON;
                    end
                end
            endcase
        end
    end

    // Output logic
    always_comb begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0; // Default case for safety
        endcase
    end

endmodule
```