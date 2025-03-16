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
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            LOW: begin
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_0_1;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_1_2;
                end else begin
                    next_state = HIGH;
                end
            end
            BETWEEN_0_1: begin
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_0_1;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_1_2;
                end else begin
                    next_state = HIGH;
                end
            end
            BETWEEN_1_2: begin
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_0_1;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_1_2;
                end else begin
                    next_state = HIGH;
                end
            end
            HIGH: begin
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b001) begin
                    next_state = BETWEEN_0_1;
                end else if (s == 3'b011) begin
                    next_state = BETWEEN_1_2;
                end else begin
                    next_state = HIGH;
                end
            end
            default: next_state = LOW;
        endcase
    end

    always @(*) begin
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
            end
            BETWEEN_0_1: begin
                fr1 = 1'b1;
                fr0 = 1'b1;
                if (next_state == BETWEEN_1_2) begin
                    dfr = 1'b1;
                end
            end
            BETWEEN_1_2: begin
                fr0 = 1'b1;
                if (next_state == HIGH) begin
                    dfr = 1'b1;
                end
            end
            HIGH: begin
                // No flow rate needed
            end
        endcase
    end

endmodule