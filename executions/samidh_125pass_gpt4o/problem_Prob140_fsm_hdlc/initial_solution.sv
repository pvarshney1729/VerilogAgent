```verilog
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Active high synchronous reset
    input logic in,           // Serial data input
    output logic disc,        // Assert high for one cycle after detecting a discard pattern
    output logic flag,        // Assert high for one cycle after detecting a flag pattern
    output logic err          // Assert high for one cycle after detecting an error pattern
);

    typedef enum logic [2:0] {
        IDLE,
        DETECT_1,
        FLAG,
        ERROR,
        DISCARD
    } state_t;

    state_t current_state, next_state;
    logic [6:0] shift_reg;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 7'b0;
        end else begin
            current_state <= next_state;
            shift_reg <= {shift_reg[5:0], in};
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (shift_reg == 7'b0111110) begin
                    next_state = DISCARD;
                end else if (shift_reg == 7'b01111110) begin
                    next_state = FLAG;
                end else if (shift_reg[6:0] == 7'b1111111) begin
                    next_state = ERROR;
                end
            end

            DISCARD: begin
                disc = 1'b1;
                next_state = IDLE;
            end

            FLAG: begin
                flag = 1'b1;
                next_state = IDLE;
            end

            ERROR: begin
                err = 1'b1;
                if (in == 1'b0) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
```