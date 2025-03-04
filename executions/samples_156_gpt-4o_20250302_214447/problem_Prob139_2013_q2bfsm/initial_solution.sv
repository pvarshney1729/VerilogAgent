```verilog
module TopModule (
    input logic clk,         // Clock input, positive edge-triggered
    input logic resetn,      // Synchronous active low reset
    input logic x,           // 1-bit input from motor
    input logic y,           // 1-bit input from motor
    output logic f,          // 1-bit output to control motor, initial state 0
    output logic g           // 1-bit output to control motor, initial state 0
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [1:0] y_counter;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_A && next_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            if (current_state == STATE_E && next_state == STATE_F) begin
                g <= 1'b1;
            end else if (current_state == STATE_F && y_counter == 2'b10) begin
                g <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (x) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                if (!x) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (x) begin
                    next_state = STATE_E;
                end
            end
            STATE_E: begin
                next_state = STATE_F;
            end
            STATE_F: begin
                if (y) begin
                    next_state = STATE_A;
                end else if (y_counter == 2'b01) begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Y counter logic
    always_ff @(posedge clk) begin
        if (current_state == STATE_F) begin
            if (!y) begin
                y_counter <= y_counter + 1;
            end else begin
                y_counter <= 2'b00;
            end
        end else begin
            y_counter <= 2'b00;
        end
    end

endmodule
```