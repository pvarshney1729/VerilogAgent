module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        S1      = 3'b001,
        S2      = 3'b010,
        S3      = 3'b011,
        S4      = 3'b100,
        S5      = 3'b101,
        DISCARD = 3'b110,
        FLAG    = 3'b111,
        ERROR   = 3'b110
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
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = IDLE;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = IDLE;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = IDLE;
            end
            S5: begin
                if (in) next_state = ERROR;
                else next_state = DISCARD;
            end
            DISCARD: begin
                disc = 1'b1;
                next_state = IDLE;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = IDLE;
            end
            ERROR: begin
                err = 1'b1;
                if (!in) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule