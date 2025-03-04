module TopModule (
    input logic clk,          // Clock input, positive-edge triggered
    input logic reset,        // Synchronous active high reset
    input logic data,         // Serial input data stream, 1 bit
    output logic start_shifting // Output signal to start shifting, 1 bit
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = IDLE;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else begin
            if (current_state == FOUND)
                start_shifting <= 1'b1;
            else
                start_shifting <= 1'b0;
        end
    end

endmodule