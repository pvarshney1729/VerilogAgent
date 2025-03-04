module TopModule (
    input logic clk,     // Clock signal, positive edge-triggered
    input logic reset,   // Active-high synchronous reset
    input logic j,       // Input signal 'j', 1-bit
    input logic k,       // Input signal 'k', 1-bit
    output logic out     // Output signal 'out', 1-bit
);

    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            case (current_state)
                OFF: begin
                    if (j) begin
                        current_state <= ON;
                        out <= 1'b1;
                    end
                end
                ON: begin
                    if (k) begin
                        current_state <= OFF;
                        out <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule