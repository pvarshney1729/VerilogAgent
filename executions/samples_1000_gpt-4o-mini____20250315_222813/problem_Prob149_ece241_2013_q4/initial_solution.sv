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

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
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
                    next_state = HIGH;
                end else if (s[1]) begin
                    next_state = ABOVE;
                end else begin
                    next_state = LOW;
                end
            end
            HIGH: begin
                if (s[0]) begin
                    next_state = ABOVE;
                end else begin
                    next_state = LOW;
                end
            end
            ABOVE: begin
                next_state = ABOVE;
            end
            default: next_state = LOW;
        endcase
    end

    // Output logic based on state
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
            MID: begin
                fr0 = 1'b1;
                dfr = 1'b1;
            end
            HIGH: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            ABOVE: begin
                // No flow
            end
        endcase
    end

endmodule