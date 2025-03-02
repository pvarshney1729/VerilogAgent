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
                if (s[0]) begin
                    next_state = MID;
                end else if (s[1]) begin
                    next_state = HIGH;
                end else if (s[2]) begin
                    next_state = ABOVE;
                end else begin
                    next_state = LOW;
                end
            end
            MID: begin
                if (s[0]) begin
                    next_state = LOW;
                end else if (s[1]) begin
                    next_state = HIGH;
                end else if (s[2]) begin
                    next_state = ABOVE;
                end else begin
                    next_state = MID;
                end
            end
            HIGH: begin
                if (s[0]) begin
                    next_state = LOW;
                end else if (s[1]) begin
                    next_state = MID;
                end else if (s[2]) begin
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
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW: begin
                fr2 = 1'b1;
                fr1 = 1'b1;
                fr0 = 1'b1;
            end
            MID: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
            end
            HIGH: begin
                fr0 = 1'b1;
            end
            ABOVE: begin
                // No flow rates asserted
            end
        endcase

        // Control dfr based on state transition
        if (current_state == LOW && next_state == MID) begin
            dfr = 1'b1; // Open supplemental flow valve
        end else if (current_state == MID && next_state == HIGH) begin
            dfr = 1'b1; // Open supplemental flow valve
        end else begin
            dfr = 1'b0; // Close supplemental flow valve
        end
    end

endmodule