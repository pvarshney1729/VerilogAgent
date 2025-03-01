```verilog
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
        BETWEEN_S0_S1 = 2'b01,
        BETWEEN_S1_S2 = 2'b10,
        ABOVE_S2 = 2'b11
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
                if (s[0]) begin
                    next_state = BETWEEN_S0_S1;
                    dfr = 1'b1;
                end else begin
                    next_state = LOW;
                end
            end
            BETWEEN_S0_S1: begin
                fr1 = 1'b1;
                fr0 = 1'b1;
                if (s[1]) begin
                    next_state = BETWEEN_S1_S2;
                    dfr = 1'b1;
                end else if (!s[0]) begin
                    next_state = LOW;
                end else begin
                    next_state = BETWEEN_S0_S1;
                end
            end
            BETWEEN_S1_S2: begin
                fr0 = 1'b1;
                if (s[2]) begin
                    next_state = ABOVE_S2;
                    dfr = 1'b1;
                end else if (!s[1]) begin
                    next_state = BETWEEN_S0_S1;
                end else begin
                    next_state = BETWEEN_S1_S2;
                end
            end
            ABOVE_S2: begin
                if (!s[2]) begin
                    next_state = BETWEEN_S1_S2;
                end else begin
                    next_state = ABOVE_S2;
                end
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end

endmodule
```