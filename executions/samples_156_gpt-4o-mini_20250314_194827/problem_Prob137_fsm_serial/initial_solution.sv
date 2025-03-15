module fsm_example (
    input logic clk,
    input logic reset,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COUNT = 2'b01,
        DONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] counter;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                counter <= counter + 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                next_state = COUNT;
                done = 1'b0;
            end
            COUNT: begin
                if (counter == 4'b1111) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNT;
                end
                done = 1'b0;
            end
            DONE: begin
                next_state = IDLE;
                done = 1'b1;
            end
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end

endmodule