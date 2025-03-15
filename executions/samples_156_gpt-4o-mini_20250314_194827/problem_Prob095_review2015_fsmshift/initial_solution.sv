module TopModule (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic shift_ena
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            shift_counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (shift_ena) begin
                shift_counter <= shift_counter + 1'b1;
            end else begin
                shift_counter <= 4'b0000;
            end
        end
    end

    // State machine for pattern detection
    always @(*) begin
        case (current_state)
            S0: begin
                if (data_in) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (data_in) begin
                    next_state = S2;
                end else begin
                    next_state = S0;
                end
            end
            S2: begin
                if (data_in) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
            end
            S3: begin
                if (data_in) begin
                    next_state = S3; // Stay in S3 if the pattern continues
                end else begin
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end

    // Shift enable logic for 4 clock cycles
    assign shift_ena = (current_state == S3 && shift_counter < 4'b0011);

endmodule