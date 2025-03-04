module TopModule (
    input wire clk,        // Clock signal, triggers state transitions on the rising edge
    input wire reset,      // Active-high synchronous reset
    input wire j,          // Input signal j
    input wire k,          // Input signal k
    output reg out         // Output signal, declared as reg for state retention
);

    // State Encoding
    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state;

    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            case (state)
                OFF: begin
                    out <= 1'b0;
                    if (j) state <= ON;
                end
                ON: begin
                    out <= 1'b1;
                    if (k) state <= OFF;
                end
            endcase
        end
    end

endmodule