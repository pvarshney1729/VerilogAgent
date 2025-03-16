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
        LOW = 2'b00,
        BETWEEN_0_1 = 2'b01,
        BETWEEN_1_2 = 2'b10,
        ABOVE_2 = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                fr0 = 1'b1;
                dfr = 1'b1;
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b001) next_state = BETWEEN_0_1;
                else if (s == 3'b011) next_state = BETWEEN_1_2;
                else next_state = ABOVE_2;
            end

            BETWEEN_0_1: begin
                fr1 = 1'b1;
                fr0 = 1'b1;
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b001) next_state = BETWEEN_0_1;
                else if (s == 3'b011) next_state = BETWEEN_1_2;
                else next_state = ABOVE_2;
            end

            BETWEEN_1_2: begin
                fr0 = 1'b1;
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b001) next_state = BETWEEN_0_1;
                else if (s == 3'b011) next_state = BETWEEN_1_2;
                else next_state = ABOVE_2;
            end

            ABOVE_2: begin
                if (s == 3'b111) next_state = ABOVE_2;
                else if (s == 3'b011) next_state = BETWEEN_1_2;
                else if (s == 3'b001) next_state = BETWEEN_0_1;
                else next_state = LOW;
            end

            default: next_state = LOW;
        endcase

        // Determine dfr based on state transition
        if (current_state < next_state) begin
            dfr = 1'b1;
        end
    end

endmodule
[END]