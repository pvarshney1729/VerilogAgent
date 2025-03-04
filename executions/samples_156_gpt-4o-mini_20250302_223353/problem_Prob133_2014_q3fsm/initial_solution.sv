module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] count_w; // Counter for w = 1 in 3 cycles
    logic [1:0] cycle_count; // Cycle counter for 3 cycles

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            z <= 1'b0;
            count_w <= 2'b00;
            cycle_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                if (cycle_count < 2'b10) begin
                    cycle_count <= cycle_count + 1'b1;
                    if (w) begin
                        count_w <= count_w + 1'b1;
                    end
                end else begin
                    if (count_w == 2'b10) begin
                        z <= 1'b1;
                    end else begin
                        z <= 1'b0;
                    end
                    // Reset for next observation window
                    count_w <= 2'b00;
                    cycle_count <= 2'b00;
                end
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            next_state <= STATE_A;
        end else begin
            case (current_state)
                STATE_A: begin
                    if (s) begin
                        next_state <= STATE_B;
                    end else begin
                        next_state <= STATE_A;
                    end
                end
                STATE_B: begin
                    if (!s) begin
                        next_state <= STATE_A;
                    end else begin
                        next_state <= STATE_B;
                    end
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly