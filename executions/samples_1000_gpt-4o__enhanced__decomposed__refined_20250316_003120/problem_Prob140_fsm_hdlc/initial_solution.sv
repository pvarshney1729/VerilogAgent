module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    // State encoding
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
                if (in == 1'b1) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in == 1'b1) begin
                    next_state = S2;
                end else begin
                    next_state = IDLE;
                end
            end
            S2: begin
                if (in == 1'b1) begin
                    next_state = S3;
                end else begin
                    next_state = IDLE;
                end
            end
            S3: begin
                if (in == 1'b1) begin
                    next_state = S4;
                end else begin
                    next_state = IDLE;
                end
            end
            S4: begin
                if (in == 1'b1) begin
                    next_state = S5;
                end else begin
                    next_state = IDLE;
                end
            end
            S5: begin
                if (in == 1'b1) begin
                    next_state = S6;
                end else begin
                    next_state = IDLE;
                end
            end
            S6: begin
                if (in == 1'b0) begin
                    disc = 1'b1;
                    next_state = S1;
                end else if (in == 1'b1) begin
                    next_state = ERROR;
                end else begin
                    next_state = IDLE;
                end
            end
            ERROR: begin
                err = 1'b1;
                if (in == 1'b0) begin
                    next_state = S1;
                end
            end
        endcase
    end

endmodule