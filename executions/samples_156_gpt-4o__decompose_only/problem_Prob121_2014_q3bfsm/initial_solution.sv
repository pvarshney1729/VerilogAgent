module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_000 = 3'b000,
        STATE_001 = 3'b001,
        STATE_010 = 3'b010,
        STATE_011 = 3'b011,
        STATE_100 = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_000;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            STATE_000: begin
                next_state = (x == 1'b0) ? STATE_000 : STATE_001;
                z = 1'b0;
            end
            STATE_001: begin
                next_state = (x == 1'b0) ? STATE_001 : STATE_100;
                z = 1'b0;
            end
            STATE_010: begin
                next_state = (x == 1'b0) ? STATE_010 : STATE_001;
                z = 1'b0;
            end
            STATE_011: begin
                next_state = (x == 1'b0) ? STATE_001 : STATE_010;
                z = 1'b1;
            end
            STATE_100: begin
                next_state = (x == 1'b0) ? STATE_011 : STATE_100;
                z = 1'b1;
            end
            default: begin
                next_state = STATE_000;
                z = 1'b0;
            end
        endcase
    end

endmodule