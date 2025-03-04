module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic resetn,       // Synchronous active-low reset
    input logic x,            // Input signal from the motor
    input logic y,            // Input signal from the motor
    output logic f,           // Output control signal to the motor
    output logic g            // Output control signal to the motor
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence;
    logic [1:0] y_counter;

    // State register
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

    // Next state logic
    always_comb begin
        next_state = current_state;
        f = 1'b0; // Default output
        case (current_state)
            STATE_A: begin
                if (resetn) next_state = STATE_B;
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 2'b10 && x) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y_counter < 2) begin
                    if (y) begin
                        g = 1'b1;
                        y_counter = 2'b11; // Lock g to 1 permanently
                    end else begin
                        y_counter = y_counter + 1;
                    end
                end else begin
                    g = 1'b0;
                end
            end
        endcase
    end

    // Sequence detection for x in state C
    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            x_sequence <= {x_sequence[0], x};
        end else begin
            x_sequence <= 2'b00;
        end
    end

    // Reset y_counter when not in STATE_D
    always_ff @(posedge clk) begin
        if (current_state != STATE_D) begin
            y_counter <= 2'b00;
        end
    end

endmodule