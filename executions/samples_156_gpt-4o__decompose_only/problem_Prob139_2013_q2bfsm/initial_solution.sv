module TopModule (
    input  logic clk,
    input  logic resetn,
    input  logic x,
    input  logic y,
    output logic f,
    output logic g
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000, // Initial state
        STATE_B = 3'b001, // Output f = 1 for one clock cycle
        STATE_C = 3'b010, // Monitor x for sequence 1, 0, 1
        STATE_D = 3'b011, // Set g = 1 and monitor y
        STATE_E = 3'b100, // Maintain g = 1 permanently
        STATE_F = 3'b101  // Set g = 0 permanently
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;
    logic [2:0] x_sequence;

    // State transition and output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;
            case (current_state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
                STATE_B: begin
                    f <= 1'b1;
                end
                STATE_C: begin
                    f <= 1'b0;
                    x_sequence <= {x_sequence[1:0], x};
                end
                STATE_D: begin
                    g <= 1'b1;
                end
                STATE_E: begin
                    // g remains 1 or 0 based on y input
                end
                STATE_F: begin
                    g <= 1'b0;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 3'b101) next_state = STATE_D;
            end
            STATE_D: begin
                next_state = STATE_E;
            end
            STATE_E: begin
                if (y) begin
                    next_state = STATE_E; // Stay in STATE_E if y is 1
                end else if (y_counter == 2'b10) begin
                    next_state = STATE_F; // Move to STATE_F if y is not 1 within two cycles
                end else begin
                    y_counter = y_counter + 1;
                end
            end
            STATE_F: begin
                // Remain in STATE_F
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule