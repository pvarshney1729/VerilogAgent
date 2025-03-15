module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    typedef logic state_t;
    state_t state, next_state;

    // State encoding
    localparam OFF = 1'b0;
    localparam ON = 1'b1;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            end
            default: begin
                next_state = OFF; // Default case to avoid latches
            end
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == ON) ? 1'b1 : 1'b0;
    end

endmodule