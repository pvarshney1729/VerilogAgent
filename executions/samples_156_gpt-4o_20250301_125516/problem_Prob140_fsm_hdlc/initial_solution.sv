module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic reset,         // Active high synchronous reset
    input logic in,            // Input data stream, 1-bit
    output logic disc,         // Output signal to discard a bit, 1-bit
    output logic flag,         // Output signal for frame flag, 1-bit
    output logic err           // Output signal for error, 1-bit
);

    typedef enum logic [2:0] {
        STATE_0 = 3'b000,
        STATE_1 = 3'b001,
        STATE_2 = 3'b010,
        STATE_3 = 3'b011,
        STATE_4 = 3'b100,
        STATE_5 = 3'b101,
        STATE_6 = 3'b110,
        STATE_7 = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            STATE_0: begin
                if (in == 1'b1) next_state = STATE_1;
            end
            STATE_1: begin
                if (in == 1'b1) next_state = STATE_2;
                else next_state = STATE_0;
            end
            STATE_2: begin
                if (in == 1'b1) next_state = STATE_3;
                else next_state = STATE_0;
            end
            STATE_3: begin
                if (in == 1'b1) next_state = STATE_4;
                else next_state = STATE_0;
            end
            STATE_4: begin
                if (in == 1'b1) next_state = STATE_5;
                else next_state = STATE_0;
            end
            STATE_5: begin
                if (in == 1'b1) next_state = STATE_6;
                else next_state = STATE_0;
            end
            STATE_6: begin
                if (in == 1'b1) next_state = STATE_7;
                else begin
                    flag = 1'b1;
                    next_state = STATE_0;
                end
            end
            STATE_7: begin
                err = 1'b1;
                next_state = STATE_7;
            end
        endcase
    end

endmodule