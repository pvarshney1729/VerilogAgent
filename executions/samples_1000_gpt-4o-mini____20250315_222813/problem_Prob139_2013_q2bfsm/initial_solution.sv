module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
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
    logic [2:0] x_counter; // To count the occurrences of x = 1
    logic y_detected;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 3'b000;
        end else if (current_state == STATE_B) begin
            f <= 1'b1;
        end else if (current_state == STATE_C) begin
            if (x_counter == 3'b101) begin
                g <= 1'b1;
            end
        end else if (current_state == STATE_D) begin
            if (y_detected) begin
                g <= 1'b1;
            end else begin
                g <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        y_detected = 1'b0;

        case (current_state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x == 1'b1) begin
                    x_counter = x_counter + 1;
                end else begin
                    x_counter = 3'b000;
                end
                if (x_counter == 3'b101) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y == 1'b1) begin
                    y_detected = 1'b1;
                    next_state = STATE_D;
                end else if (x_counter == 3'b101) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
            end
        endcase
    end

endmodule