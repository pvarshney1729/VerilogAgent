module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);

    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S1    = 3'b001,
        S2    = 3'b010,
        S3    = 3'b011,
        FOUND = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (data)
                    next_state = S2;
                else
                    next_state = IDLE;
            end
            S2: begin
                if (!data)
                    next_state = S3;
                else
                    next_state = S2;
            end
            S3: begin
                if (data)
                    next_state = FOUND;
                else
                    next_state = IDLE;
            end
            FOUND: begin
                next_state = FOUND;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register logic
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (current_state == FOUND)
            start_shifting <= 1'b1;
    end

endmodule