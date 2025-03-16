module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [2:0] s,
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

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            LOW: begin
                if (s[0] == 1'b1) begin
                    next_state = MID;
                end else if (s[1] == 1'b1) begin
                    next_state = HIGH;
                end else if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end else begin
                    next_state = LOW;
                end
            end
            MID: begin
                if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end else if (s[0] == 1'b1) begin
                    next_state = LOW;
                end else begin
                    next_state = MID;
                end
            end
            HIGH: begin
                if (s[2] == 1'b1) begin
                    next_state = ABOVE;
                end else if (s[1] == 1'b1) begin
                    next_state = MID;
                end else if (s[0] == 1'b1) begin
                    next_state = LOW;
                end else begin
                    next_state = HIGH;
                end
            end
            ABOVE: begin
                if (s[2] == 1'b0) begin
                    next_state = HIGH;
                end else begin
                    next_state = ABOVE;
                end
            end
            default: next_state = LOW;
        endcase
    end

    always @(*) begin
        fr2 = (current_state == LOW);
        fr1 = (current_state == LOW || current_state == HIGH);
        fr0 = (current_state == LOW || current_state == MID);
        dfr = (current_state == HIGH && next_state == LOW);
    end

endmodule