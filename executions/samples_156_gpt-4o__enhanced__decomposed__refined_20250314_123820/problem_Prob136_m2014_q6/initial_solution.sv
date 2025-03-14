[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    // State encoding
    localparam logic [2:0] STATE_A = 3'b000,
                           STATE_B = 3'b001,
                           STATE_C = 3'b010,
                           STATE_D = 3'b011,
                           STATE_E = 3'b100,
                           STATE_F = 3'b101;

    logic [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            STATE_A: begin
                next_state = (w == 1'b0) ? STATE_B : STATE_A;
                z = 1'b0;
            end
            STATE_B: begin
                next_state = (w == 1'b0) ? STATE_C : STATE_D;
                z = 1'b0;
            end
            STATE_C: begin
                next_state = (w == 1'b0) ? STATE_E : STATE_D;
                z = 1'b0;
            end
            STATE_D: begin
                next_state = (w == 1'b0) ? STATE_F : STATE_A;
                z = 1'b0;
            end
            STATE_E: begin
                next_state = (w == 1'b0) ? STATE_E : STATE_D;
                z = 1'b1;
            end
            STATE_F: begin
                next_state = (w == 1'b0) ? STATE_C : STATE_D;
                z = 1'b1;
            end
            default: begin
                next_state = STATE_A;
                z = 1'b0;
            end
        endcase
    end
endmodule
[DONE]