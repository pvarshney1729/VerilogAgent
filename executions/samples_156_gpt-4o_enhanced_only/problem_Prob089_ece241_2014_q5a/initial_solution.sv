module TopModule(
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,   // Initial state
        INVERT = 2'b01, // State where we start inverting bits
        ADD_ONE = 2'b10 // State where we add one to the inverted bits
    } state_t;

    state_t current_state, next_state;

    // State transition on positive edge of clock or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (x == 1'b1) begin
                    next_state = INVERT;
                end else begin
                    next_state = IDLE;
                end
            end
            INVERT: begin
                next_state = ADD_ONE;
            end
            ADD_ONE: begin
                next_state = ADD_ONE; // Stay in ADD_ONE until reset
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic (Moore machine: output based only on current state)
    always_comb begin
        case (current_state)
            IDLE: z = 1'b0;
            INVERT: z = ~x;
            ADD_ONE: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule