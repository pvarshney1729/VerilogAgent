[BEGIN]
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
    logic [2:0] x_count;
    logic y_flag;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_count <= 3'b000;
            y_flag <= 1'b0;
        end else begin
            current_state <= next_state;
            f <= (current_state == STATE_B) ? 1'b1 : 1'b0;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_B) begin
            x_count <= {x_count[1:0], x};
        end else if (current_state == STATE_A) begin
            x_count <= 3'b000; // Reset x_count on entering STATE_A
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            y_flag <= y;
        end else if (current_state == STATE_A) begin
            y_flag <= 1'b0; // Reset y_flag on entering STATE_A
        end
    end

    always_comb begin
        g = 1'b0; // Default value for g
        case (current_state)
            STATE_A: begin
                next_state = STATE_B;
            end
            STATE_B: begin
                if (x_count == 3'b101) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (y_flag) begin
                    g = 1'b1;
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                g = 1'b0;
                next_state = STATE_D;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
[DONE]