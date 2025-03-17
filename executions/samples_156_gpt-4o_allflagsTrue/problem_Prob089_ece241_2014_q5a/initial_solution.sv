module TopModule(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        INVERT = 2'b00,
        PASS = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= INVERT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            INVERT: next_state = PASS;
            PASS: next_state = PASS;
            default: next_state = INVERT;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            INVERT: z = ~x;
            PASS: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule