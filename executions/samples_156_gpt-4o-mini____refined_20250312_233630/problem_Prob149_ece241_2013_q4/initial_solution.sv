[BEGIN]
```verilog
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
        BETWEEN_S1_S0 = 2'b01,
        BETWEEN_S2_S1 = 2'b10,
        HIGH = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;
        next_state = current_state; // Default to hold state

        case (current_state)
            LOW: begin
                if (s == 3'b000) begin
                    fr2 = 1'b1;
                    fr1 = 1'b1;
                    fr0 = 1'b1;
                end else if (s[0]) begin
                    next_state = BETWEEN_S1_S0;
                end else if (s[1]) begin
                    next_state = BETWEEN_S2_S1;
                end else if (s[2]) begin
                    next_state = HIGH;
                end
            end

            BETWEEN_S1_S0: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (s[2]) begin
                    next_state = HIGH;
                end else if (s[1]) begin
                    next_state = BETWEEN_S2_S1;
                end else if (!s[0]) begin
                    next_state = LOW;
                end
            end

            BETWEEN_S2_S1: begin
                fr0 = 1'b1;
                if (!s[1]) begin
                    next_state = LOW;
                end else if (!s[0]) begin
                    next_state = BETWEEN_S1_S0;
                end
            end

            HIGH: begin
                if (!s[2]) begin
                    next_state = BETWEEN_S2_S1;
                end
            end
        endcase

        if (current_state < next_state) begin
            dfr = 1'b1;
        end
    end

endmodule
```
[DONE]