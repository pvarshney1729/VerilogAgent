module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active-high reset
    input logic data,         // Serial input data stream, one bit
    output logic start_shifting // Output signal, one bit
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S11  = 3'b010,
        S110 = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else if (current_state == FOUND) begin
            start_shifting <= 1'b1;
        end else begin
            start_shifting <= 1'b0; // Reset output when not in FOUND state
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1) 
                    next_state = S1;
                else 
                    next_state = IDLE;
            end
            S1: begin
                if (data == 1'b1) 
                    next_state = S11;
                else 
                    next_state = IDLE;
            end
            S11: begin
                if (data == 1'b0) 
                    next_state = S110;
                else 
                    next_state = S1;
            end
            S110: begin
                if (data == 1'b1) 
                    next_state = FOUND;
                else 
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND; // Remain in FOUND state
            end
            default: next_state = IDLE; // Default case
        endcase
    end

endmodule