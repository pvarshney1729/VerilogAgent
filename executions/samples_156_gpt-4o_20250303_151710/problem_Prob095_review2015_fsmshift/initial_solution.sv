```verilog
module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    // Define the pattern to be detected
    localparam logic [3:0] PATTERN = 4'b1010;

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        ENABLE = 2'b01,
        WAIT = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_shift_reg;
    logic [2:0] cycle_count;

    // Sequential logic for state transitions and outputs
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= ENABLE;
            cycle_count <= 3'b000;
            shift_ena <= 1'b1;
        end else begin
            current_state <= next_state;
            if (current_state == ENABLE) begin
                cycle_count <= cycle_count + 1;
            end else begin
                cycle_count <= 3'b000;
            end
        end
    end

    // Combinational logic for next state and output logic
    always_comb begin
        next_state = current_state;
        shift_ena = 1'b0;
        case (current_state)
            IDLE: begin
                if (pattern_shift_reg == PATTERN) begin
                    next_state = ENABLE;
                end
            end
            ENABLE: begin
                shift_ena = 1'b1;
                if (cycle_count == 3'b011) begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (pattern_shift_reg != PATTERN) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Shift register to detect the pattern
    always_ff @(posedge clk) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0000;
        end else begin
            pattern_shift_reg <= {pattern_shift_reg[2:0], 1'b0}; // Assuming input bit is 0 for simplicity
        end
    end

endmodule
```