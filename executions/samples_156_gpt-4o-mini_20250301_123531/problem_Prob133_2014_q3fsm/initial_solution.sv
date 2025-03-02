module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;
    
    logic [1:0] count_w; // Count of w = 1 over three cycles
    logic [2:0] cycle_counter; // Cycle counter for three cycles

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;
            z <= 1'b0;
            count_w <= 2'b00;
            cycle_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state == STATE_B) begin
                if (cycle_counter < 3'b011) begin
                    if (w) count_w <= count_w + 1;
                    cycle_counter <= cycle_counter + 1;
                end
                if (cycle_counter == 3'b011) begin
                    z <= (count_w == 2'b10) ? 1'b1 : 1'b0;
                    count_w <= 2'b00; // Reset count for next evaluation
                    cycle_counter <= 3'b000; // Reset cycle counter
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= STATE_A;
        end else begin
            case (state)
                STATE_A: begin
                    if (s) next_state <= STATE_B;
                    else next_state <= STATE_A;
                end
                STATE_B: begin
                    if (~s) next_state <= STATE_A;
                    else next_state <= STATE_B;
                end
            endcase
        end
    end

endmodule