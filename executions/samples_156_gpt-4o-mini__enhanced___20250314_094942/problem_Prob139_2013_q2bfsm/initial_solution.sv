module TopModule (
    input wire clk,            // Clock input (positive edge triggered)
    input wire resetn,        // Synchronous active-low reset
    input wire x,             // Input signal from the motor
    input wire y,             // Second input signal from the motor
    output reg f,             // Output control signal 1 bit
    output reg g              // Output control signal 1 bit
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] x_counter; // Counter for x sequence
    logic y_timer;         // Timer for y input

    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_counter <= 2'b00;
            y_timer <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (x_counter < 2'b11) begin
                    x_counter <= x_counter + 1;
                end
            end
            if (current_state == STATE_C) begin
                if (y_timer) begin
                    g <= g; // Maintain g
                end else begin
                    g <= 1'b0; // Reset g if timer expires
                end
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1'b1; // Set f for one clock cycle
                end
            end
            STATE_B: begin
                if (x_counter == 2'b10 && x) begin
                    next_state = STATE_C;
                    g = 1'b1; // Set g when sequence detected
                end
            end
            STATE_C: begin
                if (y) begin
                    y_timer = 1'b1; // Keep g = 1
                end else begin
                    y_timer = 1'b0; // Start timer for y
                    next_state = STATE_A; // Return to state A if y is not 1
                end
            end
        endcase
    end

endmodule