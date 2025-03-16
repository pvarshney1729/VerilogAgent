module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [3:0] {
        IDLE        = 4'b0000,
        S1          = 4'b0001,
        S2          = 4'b0010,
        S3          = 4'b0011,
        S4          = 4'b0100,
        S5          = 4'b0101,
        S6          = 4'b0110,
        DISCARD     = 4'b0111,
        FLAG        = 4'b1000,
        ERROR       = 4'b1001
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err  = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = S1;
            end
            S1: begin
                if (in == 1'b1) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (in == 1'b1) next_state = S3;
                else next_state = S1;
            end
            S3: begin
                if (in == 1'b1) next_state = S4;
                else next_state = S1;
            end
            S4: begin
                if (in == 1'b1) next_state = S5;
                else next_state = S1;
            end
            S5: begin
                if (in == 1'b1) next_state = S6;
                else next_state = S1;
            end
            S6: begin
                if (in == 1'b0) begin
                    next_state = DISCARD;
                    disc = 1'b1;
                end else begin
                    next_state = FLAG;
                    flag = 1'b1;
                end
            end
            DISCARD: begin
                next_state = S1;
            end
            FLAG: begin
                next_state = S1;
            end
            ERROR: begin
                if (in == 1'b0) next_state = S1;
                else next_state = ERROR;
                err = 1'b1;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule