```verilog
module pattern_recognizer (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        DISC = 2'b01,
        FLAG = 2'b10,
        ERR  = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [6:0] shift_reg;

    // Shift register for pattern recognition
    always_ff @(posedge clk) begin
        if (reset) begin
            shift_reg <= 7'b0;
        end else begin
            shift_reg <= {shift_reg[5:0], data_in};
        end
    end

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (shift_reg == 7'b0111110) begin
                    next_state = DISC;
                end else if (shift_reg == 7'b0111111) begin
                    next_state = FLAG;
                end else if (shift_reg == 7'b1111111) begin
                    next_state = ERR;
                end
            end
            DISC: begin
                disc = 1'b1;
                next_state = IDLE;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = IDLE;
            end
            ERR: begin
                err = 1'b1;
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```