module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);
    typedef enum logic [2:0] {
        IDLE   = 3'b000,
        S1     = 3'b001,
        S2     = 3'b010,
        S3     = 3'b011,
        FOUND  = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            IDLE:   next_state = (data) ? S1 : IDLE;
            S1:     next_state = (data) ? S2 : IDLE;
            S2:     next_state = (data) ? IDLE : S3;
            S3:     next_state = (data) ? FOUND : IDLE;
            FOUND:  next_state = FOUND;
            default: next_state = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (current_state == FOUND) begin
            start_shifting <= 1;
        end
    end
endmodule