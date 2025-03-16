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
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE = 2'b11
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            LOW: begin
                if (s[0] == 1'b0 && s[1] == 1'b0 && s[2] == 1'b0) begin
                    next_state = LOW;
                end else if (s[0] == 1'b1) begin
                    next_state = MID;
                end else if (s[1] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end
            end
            MID: begin
                if (s[0] == 1'b0) begin
                    next_state = LOW;
                end else if (s[1] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end else begin
                    next_state = MID;
                end
            end
            HIGH: begin
                if (s[0] == 1'b0) begin
                    next_state = LOW;
                end else if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end else begin
                    next_state = HIGH;
                end
            end
            ABOVE: begin
                next_state = ABOVE;
            end
            default: next_state = LOW;
        endcase
    end

    always @(*) begin
        fr2 = (state == LOW);
        fr1 = (state == LOW || state == MID);
        fr0 = (state == LOW || state == MID || state == HIGH);
        dfr = (state == MID && s[0] == 1'b1) || (state == HIGH && s[1] == 1'b1);
    end

endmodule