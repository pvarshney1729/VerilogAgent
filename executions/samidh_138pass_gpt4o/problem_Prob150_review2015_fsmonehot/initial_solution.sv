```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    logic [9:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        // Default next state
        next_state = 10'b0000000000;
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            10'b0000000001: begin // S
                if (d) next_state = 10'b0000000010;
                else next_state = 10'b0000000001;
            end
            10'b0000000010: begin // S1
                if (d) next_state = 10'b0000000100;
                else next_state = 10'b0000000001;
            end
            10'b0000000100: begin // S11
                if (d) next_state = 10'b0000000100;
                else next_state = 10'b0000001000;
            end
            10'b0000001000: begin // S110
                if (d) next_state = 10'b0000010000;
                else next_state = 10'b0000000001;
            end
            10'b0000010000: begin // B0
                next_state = 10'b0000100000;
                shift_ena = 1'b1;
            end
            10'b0000100000: begin // B1
                next_state = 10'b0001000000;
                shift_ena = 1'b1;
            end
            10'b0001000000: begin // B2
                next_state = 10'b0010000000;
                shift_ena = 1'b1;
            end
            10'b0010000000: begin // B3
                next_state = 10'b0100000000;
                shift_ena = 1'b1;
            end
            10'b0100000000: begin // Count
                if (done_counting) next_state = 10'b1000000000;
                else next_state = 10'b0100000000;
                counting = 1'b1;
            end
            10'b1000000000: begin // Wait
                if (ack) next_state = 10'b0000000001;
                else next_state = 10'b1000000000;
                done = 1'b1;
            end
            default: next_state = 10'b0000000001; // Default to state S
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 10'b0000000001; // Reset to state S
        end else begin
            current_state <= next_state;
        end
    end

endmodule
[DONE]
```