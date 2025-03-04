module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);
    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count;  // Counter for the occurrences of w = 1
    logic [1:0] cycle_count;  // Counter for the number of cycles in STATE_B

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_count == 2'b11) begin
                    if (w_count == 2'd2) begin
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                    w_count <= 2'b00;
                    cycle_count <= 2'b00;
                end else begin
                    cycle_count <= cycle_count + 1;
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (cycle_count == 2'b11) begin
                    next_state = STATE_A;
                end
            end
        endcase
    end
endmodule