```verilog
module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
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

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 2'b00;
            y_counter <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                x_sequence <= {x_sequence[0], x};
            end
            if (current_state == STATE_C) begin
                y_counter <= y_counter + 1;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        f = 1'b0;
        g = 1'b0;

        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                    f = 1'b1;
                end
            end
            STATE_B: begin
                if (x_sequence == 2'b10 && x == 1'b1) begin
                    next_state = STATE_C;
                end
            end
            STATE_C: begin
                g = 1'b1;
                if (y_counter == 2'b10) begin
                    if (y == 1'b0) begin
                        next_state = STATE_D;
                    end
                end
            end
            STATE_D: begin
                g = 1'b0;
            end
        endcase
    end

endmodule
```