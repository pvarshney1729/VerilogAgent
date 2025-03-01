module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic reset,     // Active-high synchronous reset
    input logic j,         // Input signal 'j', 1-bit
    input logic k,         // Input signal 'k', 1-bit
    output logic out       // Output signal 'out', 1-bit
);

    typedef enum logic {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= OFF;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            OFF: begin
                if (j == 1'b1) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k == 1'b1) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out <= 1'b0;
        end else begin
            case (current_state)
                OFF: out <= 1'b0;
                ON:  out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

endmodule