module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] bit_counter; // Counter for 8 data bits
    logic done_reg;

    // State transition logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 3'd7) // After 8 data bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Verify stop bit
                    next_state = IDLE;
            end
        endcase
    end

    // State and counter update logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            done_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 3'd0;
            end

            if (current_state == STOP && in == 1'b1) begin
                done_reg <= 1'b1; // Set done high when stop bit is verified
            end else begin
                done_reg <= 1'b0;
            end
        end
    end

    assign done = done_reg;

endmodule