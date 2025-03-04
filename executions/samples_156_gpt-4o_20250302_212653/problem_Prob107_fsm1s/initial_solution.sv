module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        State_B = 2'b00,
        State_A = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            State_B: begin
                if (in == 1'b0)
                    next_state = State_A;
                else
                    next_state = State_B;
            end
            State_A: begin
                if (in == 1'b0)
                    next_state = State_B;
                else
                    next_state = State_A;
            end
            default: next_state = State_B;
        endcase
    end

    // State update logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= State_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (current_state)
            State_B: out = 1'b1;
            State_A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule