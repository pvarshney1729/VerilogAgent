module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B0 = 2'b01,
        STATE_B1 = 2'b10,
        STATE_B2 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count;
    logic [1:0] cycle_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B0 || current_state == STATE_B1 || current_state == STATE_B2) begin
                if (w) begin
                    w_count <= w_count + 1;
                end
                cycle_count <= cycle_count + 1;
            end
            if (current_state == STATE_B2) begin
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
                w_count <= 2'b00;
                cycle_count <= 2'b00;
            end
        end
    end

    always_comb begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B0;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B0: begin
                if (cycle_count == 2'b10) begin
                    next_state = STATE_B1;
                end else begin
                    next_state = STATE_B0;
                end
            end
            STATE_B1: begin
                if (cycle_count == 2'b10) begin
                    next_state = STATE_B2;
                end else begin
                    next_state = STATE_B1;
                end
            end
            STATE_B2: begin
                next_state = STATE_B0;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule