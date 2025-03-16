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
        MID1 = 2'b01,
        MID2 = 2'b10,
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

    always_comb begin
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            LOW: begin
                if (s == 3'b000) begin
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    fr0 = 1'b1;
                end else if (s[0]) begin
                    next_state = MID1;
                    fr0 = 1'b1;
                    fr1 = 1'b1;
                end else if (s[1]) begin
                    next_state = MID2;
                    fr0 = 1'b1;
                end else if (s[2]) begin
                    next_state = HIGH;
                end
            end
            MID1: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (s[2]) begin
                    next_state = HIGH;
                end else if (!s[0]) begin
                    next_state = LOW;
                end
            end
            MID2: begin
                fr0 = 1'b1;
                if (!s[0]) begin
                    next_state = LOW;
                end else if (s[2]) begin
                    next_state = HIGH;
                end
            end
            HIGH: begin
                // No flow rate
                if (!s[2]) begin
                    next_state = MID2;
                end
            end
        endcase

        // Determine if we need to open the supplemental flow valve
        if (current_state < next_state) begin
            dfr = 1'b1;
        end
    end

endmodule