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
    logic [2:0] x_count; // To count the occurrences of x = 1
    logic y_timer; // To track the timing for y input

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_count <= 3'b000;
            y_timer <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            f <= 1'b0;
            g <= 1'b0;
            x_count <= 3'b000;
            y_timer <= 1'b0;
        end else if (current_state == STATE_B) begin
            f <= 1'b1; // Set f to 1 for one clock cycle
            x_count <= (x_count == 3'b000) ? 3'b001 : x_count + 1;
        end else if (current_state == STATE_C) begin
            if (x_count == 3'b011) begin
                g <= 1'b1; // Set g to 1 after 1, 0, 1
                y_timer <= 1'b1; // Start monitoring y
            end
        end else if (current_state == STATE_D) begin
            if (y_timer) begin
                if (y) begin
                    g <= 1'b1; // Maintain g = 1 if y = 1
                end else begin
                    g <= 1'b0; // Set g = 0 if y does not become 1
                end
            end
        end
    end

    always_comb begin
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
                if (x_count == 3'b011) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_D: begin
                if (y_timer) begin
                    next_state = STATE_D; // Stay in STATE_D
                end else begin
                    next_state = STATE_A; // Reset to STATE_A
                end
            end
            default: next_state = STATE_A;
        endcase
    end

endmodule