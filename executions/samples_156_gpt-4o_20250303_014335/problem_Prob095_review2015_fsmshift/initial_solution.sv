module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE_1 = 2'b01,
        ENABLE_2 = 2'b10,
        ENABLE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] enable_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE_1;
            enable_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state != IDLE) begin
                enable_counter <= enable_counter + 1;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (reset) begin
                    next_state = ENABLE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            ENABLE_1: begin
                if (enable_counter == 2'b11) begin
                    next_state = IDLE;
                end else begin
                    next_state = ENABLE_2;
                end
            end
            ENABLE_2: begin
                if (enable_counter == 2'b11) begin
                    next_state = IDLE;
                end else begin
                    next_state = ENABLE_3;
                end
            end
            ENABLE_3: begin
                if (enable_counter == 2'b11) begin
                    next_state = IDLE;
                end else begin
                    next_state = ENABLE_1;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        shift_ena = (current_state != IDLE);
    end

endmodule