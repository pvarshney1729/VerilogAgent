module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic resetn,       // Active low synchronous reset
    input logic x,            // Input signal from motor
    input logic y,            // Input signal from motor
    output logic f,           // Output to control the motor
    output logic g            // Output to control the motor
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            f <= 1'b0;
            if (resetn) begin
                next_state <= STATE_B;
                f <= 1'b1;
            end
        end else if (current_state == STATE_B) begin
            if (x) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_C) begin
            if (x && !y_counter) begin
                y_counter <= 2'b01; // Start counting for y
            end else if (y_counter < 2'b10) begin
                y_counter <= y_counter + 1;
            end
            
            if (y_counter == 2'b01 && !y) begin
                g <= 1'b0;
                next_state <= STATE_A;
            end else if (y_counter == 2'b10 && y) begin
                g <= 1'b1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_C && y_counter == 2'b10 && !y) begin
            g <= 1'b0;
        end
    end

endmodule