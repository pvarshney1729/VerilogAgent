module TopModule (
    input wire clk,          // Clock signal, positive-edge triggered
    input wire resetn,       // Active-low synchronous reset
    input wire x,            // Input from motor
    input wire y,            // Input from motor
    output reg f,            // Control output for motor
    output reg g             // Control output for motor
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [1:0] x_sequence_counter;
    reg [1:0] y_monitor_counter;

    // State transition logic
    always @(posedge clk) begin
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

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end

            STATE_C: begin
                if (x_sequence_counter == 2'b10 && x == 1'b1) begin
                    next_state = STATE_D;
                end else begin
                    if (x_sequence_counter == 2'b00 && x == 1'b1) begin
                        x_sequence_counter = 2'b01;
                    end else if (x_sequence_counter == 2'b01 && x == 1'b0) begin
                        x_sequence_counter = 2'b10;
                    end else if (x_sequence_counter == 2'b10 && x == 1'b1) begin
                        x_sequence_counter = 2'b11;
                    end else begin
                        x_sequence_counter = 2'b00;
                    end
                end
            end

            STATE_D: begin
                g = 1'b1;
                if (y_monitor_counter < 2'b10) begin
                    if (y == 1'b1) begin
                        g = 1'b1;
                    end else begin
                        y_monitor_counter = y_monitor_counter + 1;
                    end
                end else begin
                    g = 1'b0;
                end
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule