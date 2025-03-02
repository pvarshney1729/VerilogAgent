module TopModule (
    input  logic clk,       // Clock signal, positive-edge triggered
    input  logic resetn,    // Synchronous active-low reset
    input  logic x,         // Motor input signal x
    input  logic y,         // Motor input signal y
    output logic f,         // Output control signal f
    output logic g          // Output control signal g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C1 = 3'b010,
        STATE_C2 = 3'b011,
        STATE_D = 3'b100,
        STATE_E = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_sequence_counter;
    logic y_check_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence_counter <= 2'b00;
            y_check_counter <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        next_state = current_state; // Default to hold state
        f = 1'b0; // Default output
        case (current_state)
            STATE_A: begin
                f = 1'b1;
                next_state = STATE_B;
            end
            STATE_B: begin
                if (x_sequence_counter == 2'b10 && x) begin
                    next_state = STATE_C1;
                    g = 1'b1;
                end else if (x_sequence_counter == 2'b01 && !x) begin
                    x_sequence_counter <= 2'b10;
                end else if (x && x_sequence_counter == 2'b00) begin
                    x_sequence_counter <= 2'b01;
                end else begin
                    x_sequence_counter <= 2'b00;
                end
            end
            STATE_C1: begin
                if (y) begin
                    next_state = STATE_D;
                end else if (y_check_counter == 1'b1) begin
                    next_state = STATE_E;
                end else begin
                    y_check_counter <= 1'b1;
                end
            end
            STATE_D: begin
                g = 1'b1;
            end
            STATE_E: begin
                g = 1'b0;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule