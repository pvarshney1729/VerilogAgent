module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic reset,        // Synchronous active-high reset
    input logic in,           // Input data stream, 1 bit
    output logic disc,        // Discard signal, 1 bit, active high
    output logic flag,        // Frame flag signal, 1 bit, active high
    output logic err          // Error signal, 1 bit, active high
);

    typedef enum logic [3:0] {
        IDLE,
        SEQ_1,
        SEQ_11,
        SEQ_111,
        SEQ_1111,
        SEQ_11111,
        SEQ_111110,
        FLAG,
        ERROR
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = SEQ_1;
            end
            SEQ_1: begin
                if (in == 1'b1) next_state = SEQ_11;
                else next_state = SEQ_1;
            end
            SEQ_11: begin
                if (in == 1'b1) next_state = SEQ_111;
                else next_state = SEQ_1;
            end
            SEQ_111: begin
                if (in == 1'b1) next_state = SEQ_1111;
                else next_state = SEQ_1;
            end
            SEQ_1111: begin
                if (in == 1'b1) next_state = SEQ_11111;
                else next_state = SEQ_1;
            end
            SEQ_11111: begin
                if (in == 1'b0) next_state = SEQ_111110;
                else next_state = ERROR;
            end
            SEQ_111110: begin
                if (in == 1'b1) next_state = FLAG;
                else next_state = SEQ_11111;
            end
            FLAG: begin
                if (in == 1'b1) next_state = ERROR;
                else next_state = SEQ_1;
            end
            ERROR: begin
                if (in == 1'b0) next_state = SEQ_1;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= (current_state == SEQ_111110);
            flag <= (current_state == FLAG);
            err <= (current_state == ERROR);
        end
    end

endmodule