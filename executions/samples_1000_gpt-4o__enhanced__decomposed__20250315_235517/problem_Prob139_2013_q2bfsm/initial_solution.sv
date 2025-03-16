module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence;
    logic [1:0] y_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state; // Default state transition
        f = 1'b0; // Default output
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1'b1;
                end
            end
            STATE_B: begin
                x_sequence = {x_sequence[0], x};
                if (x_sequence == 2'b10 && x == 1'b1) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                g = 1'b1;
                if (y) begin
                    next_state = STATE_E; // Maintain g = 1 permanently
                end else if (y_counter < 2'b10) begin
                    y_counter = y_counter + 1'b1;
                end else begin
                    next_state = STATE_D; // Set g = 0 permanently
                end
            end
            STATE_D: begin
                g = 1'b0;
            end
            STATE_E: begin
                g = 1'b1;
            end
        endcase
    end

endmodule