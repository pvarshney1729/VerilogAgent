module TopModule (
    input logic clk,           // Clock input, active on rising edge
    input logic reset,         // Active-high synchronous reset
    output logic shift_ena     // Shift enable output
);

    typedef enum logic [1:0] {
        S0,  // Initial state
        S1,  // Assert shift_ena for 4 cycles
        S2   // De-assert shift_ena
    } state_t;

    state_t state, next_state;
    logic [1:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S1;
            cycle_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == S1) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: begin
                if (reset) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (cycle_count == 2'b11) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            S2: begin
                if (reset) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            S1: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule