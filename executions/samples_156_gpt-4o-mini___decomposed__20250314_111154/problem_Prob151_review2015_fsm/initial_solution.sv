module TopModule (
    input clk,
    input reset,
    input data,
    input done_counting,
    input ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        WAIT_PATTERN = 3'b001,
        SHIFT = 3'b010,
        COUNT = 3'b011,
        DONE_STATE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_count <= 4'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            SHIFT: begin
                if (shift_count < 4) begin
                    shift_count <= shift_count + 1;
                end else begin
                    shift_count <= 4'b0;
                end
            end
            default: begin
                shift_count <= 4'b0;
            end
        endcase
    end

    always_comb begin
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = WAIT_PATTERN;
                end else begin
                    next_state = IDLE;
                end
            end
            
            WAIT_PATTERN: begin
                // Assume some pattern detection logic here
                if (/* detected 1101 pattern */) begin
                    next_state = SHIFT;
                end else begin
                    next_state = IDLE;
                end
            end

            SHIFT: begin
                shift_ena = 1'b1; // Assert shift_ena for 4 cycles
                if (shift_count == 4'b0111) begin
                    next_state = COUNT;
                end else begin
                    next_state = SHIFT;
                end
            end

            COUNT: begin
                counting = 1'b1; // Indicate counting is happening
                if (done_counting) begin
                    next_state = DONE_STATE;
                end else begin
                    next_state = COUNT;
                end
            end

            DONE_STATE: begin
                done = 1'b1; // Notify user timer is done
                if (ack) begin
                    next_state = IDLE; // Reset state after acknowledgment
                end else begin
                    next_state = DONE_STATE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly