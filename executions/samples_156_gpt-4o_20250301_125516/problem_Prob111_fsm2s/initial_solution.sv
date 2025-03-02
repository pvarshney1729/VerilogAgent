module TopModule (
    input logic clk,       // Clock signal, active on rising edge
    input logic reset,     // Synchronous active-high reset
    input logic j,         // J input, affects state transition
    input logic k,         // K input, affects state transition
    output logic out       // Output, changes based on state
);

    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end
                end
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end
                end
            endcase
        end
    end

    always_comb begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
        endcase
    end

endmodule