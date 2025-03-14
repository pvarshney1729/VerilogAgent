[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    typedef enum logic [1:0] {
        LEVEL_LOW = 2'b00,
        LEVEL_MID = 2'b01,
        LEVEL_HIGH = 2'b10,
        LEVEL_TOP = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] prev_s;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LEVEL_LOW;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            current_state <= next_state;
            prev_s <= s;
        end
    end

    always_comb begin
        next_state = current_state;
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LEVEL_LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                fr0 = 1'b1;
                dfr = 1'b1;
                if (s == 3'b001) begin
                    next_state = LEVEL_MID;
                end else if (s == 3'b011) begin
                    next_state = LEVEL_HIGH;
                end else if (s == 3'b111) begin
                    next_state = LEVEL_TOP;
                end
            end

            LEVEL_MID: begin
                fr0 = 1'b1;
                if (s == 3'b000) begin
                    next_state = LEVEL_LOW;
                end else if (s == 3'b011) begin
                    next_state = LEVEL_HIGH;
                end else if (s == 3'b111) begin
                    next_state = LEVEL_TOP;
                end
            end

            LEVEL_HIGH: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (s == 3'b000) begin
                    next_state = LEVEL_LOW;
                end else if (s == 3'b001) begin
                    next_state = LEVEL_MID;
                end else if (s == 3'b111) begin
                    next_state = LEVEL_TOP;
                end
            end

            LEVEL_TOP: begin
                if (s == 3'b000) begin
                    next_state = LEVEL_LOW;
                end else if (s == 3'b001) begin
                    next_state = LEVEL_MID;
                end else if (s == 3'b011) begin
                    next_state = LEVEL_HIGH;
                end
            end
        endcase

        if (s > prev_s) begin
            dfr = 1'b0;
        end else if (s < prev_s) begin
            dfr = 1'b1;
        end
    end
endmodule
[DONE]