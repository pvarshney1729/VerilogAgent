module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic j,
    input  logic k,
    output logic out
);

    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            OFF: begin
                out = 1'b0;
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                out = 1'b1;
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

endmodule