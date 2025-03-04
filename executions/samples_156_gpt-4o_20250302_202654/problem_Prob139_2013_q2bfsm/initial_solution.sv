module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [1:0] {
        state_A = 2'b00,
        state_B = 2'b01,
        state_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence_counter;
    logic [1:0] y_counter;
    logic y_detected;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= state_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence_counter <= 2'b00;
            y_counter <= 2'b00;
            y_detected <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == state_A && next_state == state_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end

            if (current_state == state_C) begin
                if (y_detected) begin
                    g <= 1'b1;
                end else if (y_counter == 2'b10) begin
                    g <= 1'b0;
                end else begin
                    g <= g;
                end
            end else begin
                g <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            state_A: begin
                if (resetn) begin
                    next_state = state_B;
                end
            end
            state_B: begin
                if (x_sequence_counter == 2'b11) begin
                    next_state = state_C;
                end
            end
            state_C: begin
                if (!y_detected && y_counter < 2'b10) begin
                    y_counter = y_counter + 1;
                end
                if (y) begin
                    y_detected = 1'b1;
                end
            end
        endcase
    end

    // Sequence detection logic
    always_ff @(posedge clk) begin
        if (current_state == state_B) begin
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

endmodule