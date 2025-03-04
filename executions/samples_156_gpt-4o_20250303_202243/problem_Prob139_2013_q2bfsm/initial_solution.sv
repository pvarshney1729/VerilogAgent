module TopModule (
    input logic clk,         // Clock input, positive edge triggered
    input logic resetn,      // Synchronous active low reset
    input logic x,           // 1-bit input from motor
    input logic y,           // 1-bit input from motor
    output logic f,          // 1-bit output to motor (control)
    output logic g           // 1-bit output to motor (control)
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence_counter;
    logic y_monitor_counter;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence_counter <= 2'b00;
            y_monitor_counter <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
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
                case (x_sequence_counter)
                    2'b00: if (x) x_sequence_counter = 2'b01;
                    2'b01: if (!x) x_sequence_counter = 2'b10;
                    2'b10: if (x) begin
                        next_state = STATE_D;
                        g = 1'b1;
                    end else begin
                        x_sequence_counter = 2'b00;
                    end
                endcase
            end

            STATE_D: begin
                g = 1'b1;
                if (y) begin
                    y_monitor_counter = 1'b0;
                end else begin
                    y_monitor_counter = y_monitor_counter + 1'b1;
                    if (y_monitor_counter == 2'b10) begin
                        g = 1'b0;
                    end
                end
            end
        endcase
    end

endmodule