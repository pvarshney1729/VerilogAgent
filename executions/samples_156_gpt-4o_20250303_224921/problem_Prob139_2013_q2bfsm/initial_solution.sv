module TopModule (
    input  logic clk,       // Clock input, triggers on the positive edge
    input  logic resetn,    // Synchronous active low reset
    input  logic x,         // 1-bit input from the motor
    input  logic y,         // 1-bit input from the motor
    output logic f,         // 1-bit output to control the motor
    output logic g          // 1-bit output to control the motor
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
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

    // Next state logic and output logic
    always_comb begin
        next_state = current_state;
        f = 1'b0;
        case (current_state)
            STATE_A: begin
                next_state = STATE_B;
            end
            STATE_B: begin
                f = 1'b1;
                next_state = STATE_C;
            end
            STATE_C: begin
                x_sequence = {x_sequence[0], x};
                if (x_sequence == 2'b10 && x == 1'b1) begin
                    g = 1'b1;
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y_counter < 2) begin
                    y_counter = y_counter + 1;
                    if (y == 1'b1) begin
                        g = 1'b1;
                    end else if (y_counter == 2) begin
                        g = 1'b0;
                    end
                end
            end
        endcase
    end

endmodule