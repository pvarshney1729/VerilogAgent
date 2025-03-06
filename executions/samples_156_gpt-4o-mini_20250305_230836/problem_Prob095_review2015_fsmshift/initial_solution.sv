module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);
    typedef enum logic [1:0] {
        IDLE,
        SHIFT_ENABLE
    } state_t;

    state_t current_state, next_state;
    logic [2:0] cycle_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            cycle_count <= 3'b0;
            shift_ena <= 1'b1;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT_ENABLE) begin
                if (cycle_count < 3'b011) begin
                    cycle_count <= cycle_count + 1;
                    shift_ena <= 1'b1;
                end else begin
                    shift_ena <= 1'b0;
                end
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT_ENABLE;
                end else begin
                    next_state = IDLE;
                end
            end
            SHIFT_ENABLE: begin
                if (cycle_count < 3'b011) begin
                    next_state = SHIFT_ENABLE;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule