module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence_counter;
    logic [1:0] y_monitor_counter;

    // State register
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence_counter <= 2'b00;
            y_monitor_counter <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                f = 1'b0;
                g = 1'b0;
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1'b1;
                end
            end
            STATE_B: begin
                f = 1'b0;
                g = 1'b0;
                if (x_sequence_counter == 2'b11) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                f = 1'b0;
                g = 1'b1;
                if (y_monitor_counter == 2'b10) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                f = 1'b0;
                g = 1'b0;
            end
        endcase
    end

    // Sequence detection for x
    always_ff @(posedge clk) begin
        if (current_state == STATE_B) begin
            if (x_sequence_counter == 2'b00 && x) begin
                x_sequence_counter <= 2'b01;
            end else if (x_sequence_counter == 2'b01 && !x) begin
                x_sequence_counter <= 2'b10;
            end else if (x_sequence_counter == 2'b10 && x) begin
                x_sequence_counter <= 2'b11;
            end else begin
                x_sequence_counter <= 2'b00;
            end
        end else begin
            x_sequence_counter <= 2'b00;
        end
    end

    // Monitor y for two cycles
    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            if (y) begin
                y_monitor_counter <= 2'b11; // Stay in STATE_C
            end else if (y_monitor_counter != 2'b10) begin
                y_monitor_counter <= y_monitor_counter + 1;
            end
        end else begin
            y_monitor_counter <= 2'b00;
        end
    end

endmodule