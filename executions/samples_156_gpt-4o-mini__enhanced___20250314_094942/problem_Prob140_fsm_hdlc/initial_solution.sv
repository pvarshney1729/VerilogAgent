module TopModule (
    input logic clk,           // Clock signal (1 bit)
    input logic reset,         // Active high synchronous reset (1 bit)
    input logic in,           // Data input stream (1 bit)
    output logic disc,         // Discard signal (1 bit)
    output logic flag,         // Frame flag signal (1 bit)
    output logic err           // Error signal for invalid sequence (1 bit)
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S2   = 3'b010,
        S3   = 3'b011,
        S4   = 3'b100,
        S5   = 3'b101,
        S6   = 3'b110,
        ERROR = 3'b111
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;

        case (current_state)
            IDLE: begin
                if (in) begin
                    next_state <= S1;
                end else begin
                    next_state <= IDLE;
                end
            end
            S1: begin
                if (in) begin
                    next_state <= S2;
                end else begin
                    next_state <= IDLE;
                end
            end
            S2: begin
                if (in) begin
                    next_state <= S3;
                end else begin
                    next_state <= IDLE;
                end
            end
            S3: begin
                if (in) begin
                    next_state <= S4;
                end else begin
                    next_state <= IDLE;
                end
            end
            S4: begin
                if (in) begin
                    next_state <= S5;
                end else begin
                    next_state <= IDLE;
                end
            end
            S5: begin
                if (in) begin
                    next_state <= S6;
                end else begin
                    next_state <= IDLE;
                end
            end
            S6: begin
                if (in) begin
                    next_state <= ERROR;
                end else begin
                    disc <= 1'b1; // 0111110 detected
                    next_state <= IDLE;
                end
            end
            ERROR: begin
                err <= 1'b1; // 7 or more 1s detected
                if (in) begin
                    next_state <= ERROR;
                end else begin
                    next_state <= IDLE;
                end
            end
            default: next_state <= IDLE;
        endcase

        if (current_state == S6 && in) begin
            flag <= 1'b1; // 01111110 detected
        end
    end

endmodule