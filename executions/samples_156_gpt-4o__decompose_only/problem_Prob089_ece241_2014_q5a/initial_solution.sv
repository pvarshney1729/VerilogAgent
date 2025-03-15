module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,   // Initial state, waiting for input
        INVERT = 2'b01, // State to invert bits after the first '1' is encountered
        PASS = 2'b10    // State to pass bits as they are after inversion
    } state_t;

    state_t current_state, next_state;

    // State transition logic
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
                if (x == 1'b1)
                    next_state = INVERT;
                else
                    next_state = IDLE;
            end
            INVERT: begin
                next_state = PASS;
            end
            PASS: begin
                next_state = PASS;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic based on Moore state machine
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 1'b0;
        end else begin
            case (current_state)
                IDLE: z <= 1'b0; // Output is 0 in idle state
                INVERT: z <= ~x; // Invert the input bit
                PASS: z <= x;    // Pass the input bit
                default: z <= 1'b0;
            endcase
        end
    end

endmodule