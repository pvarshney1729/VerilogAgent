module TopModule(
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B1 = 2'b01,
        STATE_B2 = 2'b10,
        STATE_B3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for w = 1 occurrences

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B3) begin
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B1;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B1: next_state = STATE_B2;
            STATE_B2: next_state = STATE_B3;
            STATE_B3: next_state = STATE_B1;
            default: next_state = STATE_A;
        endcase
    end

    // w_count logic
    always @(posedge clk) begin
        if (reset || current_state == STATE_A) begin
            w_count <= 2'b00;
        end else if (current_state == STATE_B1 || current_state == STATE_B2 || current_state == STATE_B3) begin
            if (w) begin
                w_count <= w_count + 1;
            end
        end
    end

endmodule