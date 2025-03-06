module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        state_A = 2'b01,
        state_B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= state_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        case (state)
            state_A: begin
                if (x) begin
                    next_state = state_B;
                    z = 1'b1;
                end else begin
                    next_state = state_A;
                    z = 1'b0;
                end
            end
            state_B: begin
                if (x) begin
                    next_state = state_B;
                    z = 1'b0;
                end else begin
                    next_state = state_B;
                    z = 1'b1;
                end
            end
            default: begin
                next_state = state_A;
                z = 1'b0;
            end
        endcase
    end

endmodule