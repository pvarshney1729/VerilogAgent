module fsm_with_counter (
    input logic clk,
    input logic reset,
    input logic start,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COUNT = 2'b01,
        DONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] cycle_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            cycle_count <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 4'b0000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (start) begin
                    next_state = COUNT;
                end else begin
                    next_state = IDLE;
                end
            end
            COUNT: begin
                if (cycle_count == 4'b1111) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    assign shift_ena = (current_state == COUNT);

endmodule