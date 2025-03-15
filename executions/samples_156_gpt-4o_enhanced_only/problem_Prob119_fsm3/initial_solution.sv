module TopModule(
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
            STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            default: next_state = STATE_A; // Default to state A for safety
        endcase
    end

    // State update logic (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic (combinational)
    always @(*) begin
        case (current_state)
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule