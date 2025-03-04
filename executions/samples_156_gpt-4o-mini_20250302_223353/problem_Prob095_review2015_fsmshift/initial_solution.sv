module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        IDLE,
        DETECT,
        ENABLE
    } state_t;

    state_t current_state, next_state;
    logic [1:0] counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter <= 2'b00;
            shift_ena <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE) begin
                if (counter < 2'b11) begin
                    counter <= counter + 1;
                    shift_ena <= 1'b1; // Keep shift_ena high during ENABLE state
                end else begin
                    shift_ena <= 1'b0; // De-assert shift_ena after 4 cycles
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= IDLE; // Reset state
        end else begin
            case (current_state)
                IDLE: begin
                    if (/* pattern detected */) begin
                        next_state <= ENABLE;
                        counter <= 2'b00;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                ENABLE: begin
                    if (counter < 2'b11) begin
                        next_state <= ENABLE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end

endmodule