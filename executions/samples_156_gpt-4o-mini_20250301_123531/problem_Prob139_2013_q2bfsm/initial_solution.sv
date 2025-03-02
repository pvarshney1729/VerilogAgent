```verilog
module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E
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
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
            if (current_state == STATE_C) begin
                g <= 1'b1;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            if (y == 1'b1) begin
                next_state <= STATE_D;
            end else if (y_counter < 2'b10) begin
                y_counter <= y_counter + 1;
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_E;
            end
        end else begin
            case (current_state)
                STATE_A: begin
                    next_state <= STATE_B;
                end
                STATE_B: begin
                    if (x == 1'b1) begin
                        next_state <= STATE_C;
                    end else begin
                        next_state <= STATE_B;
                    end
                end
                STATE_D: begin
                    next_state <= STATE_D;
                end
                STATE_E: begin
                    next_state <= STATE_E;
                end
                default: begin
                    next_state <= STATE_A;
                end
            endcase
        end
    end

endmodule
```