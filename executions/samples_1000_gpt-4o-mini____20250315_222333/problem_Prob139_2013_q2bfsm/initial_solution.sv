module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_sequence; // To track the sequence of x values
    logic y_timer; // To track y timing

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 3'b000;
            y_timer <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1; // Set f to 1 for one clock cycle
            end else begin
                f <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            if (!resetn) begin
                next_state <= STATE_A;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_B) begin
            x_sequence <= {x_sequence[1:0], x}; // Shift in the new x value
            if (x_sequence == 3'b101) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_C) begin
            g <= 1'b1; // Set g to 1
            y_timer <= 1'b0; // Reset y timer
            next_state <= STATE_D;
        end else if (current_state == STATE_D) begin
            if (y_timer < 2) begin
                if (y) begin
                    y_timer <= 2'b00; // Reset timer if y is 1
                end else begin
                    y_timer <= y_timer + 1'b1; // Increment timer
                end
            end else begin
                g <= 1'b0; // Set g to 0 if y is not 1 within 2 cycles
                next_state <= STATE_A; // Go back to state A
            end
        end
    end

endmodule