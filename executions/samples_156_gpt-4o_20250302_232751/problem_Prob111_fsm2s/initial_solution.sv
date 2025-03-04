module TopModule (
    input  wire i_clk,         // Clock signal, active on the rising edge
    input  wire i_reset,       // Active-high synchronous reset
    input  wire i_j,           // Input signal j
    input  wire i_k,           // Input signal k
    output reg  o_out          // Output signal, depends on the current state
);

    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (i_j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (i_k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // State register and output logic
    always @(posedge i_clk) begin
        if (i_reset) begin
            current_state <= OFF;
            o_out <= 1'b0;
        end else begin
            current_state <= next_state;
            o_out <= (current_state == ON) ? 1'b1 : 1'b0;
        end
    end

endmodule