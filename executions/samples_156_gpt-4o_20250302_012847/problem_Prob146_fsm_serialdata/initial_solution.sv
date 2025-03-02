module fsm_serial_input (
    input logic clk,
    input logic reset,
    input logic serial_in,
    output logic [3:0] bit_count,
    output logic result
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COUNT = 2'b01,
        CHECK = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] bit_counter;
    logic result_reg;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'b0000;
            result_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                bit_counter <= bit_counter + 1;
            end else if (current_state == CHECK) begin
                bit_counter <= 4'b0000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (serial_in) begin
                    next_state = COUNT;
                end else begin
                    next_state = IDLE;
                end
            end
            COUNT: begin
                if (bit_counter == 4'b1111) begin
                    next_state = CHECK;
                end else begin
                    next_state = COUNT;
                end
            end
            CHECK: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            CHECK: result_reg = (bit_counter == 4'b1111);
            default: result_reg = 1'b0;
        endcase
    end

    assign bit_count = bit_counter;
    assign result = result_reg;

endmodule