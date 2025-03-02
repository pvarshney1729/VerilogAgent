```verilog
module state_machine (
    input logic clk,
    input logic reset,
    input logic in1,
    input logic in2,
    output logic out
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (in1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (in2)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in1 && in2)
                    next_state = S3;
                else
                    next_state = S1;
            end
            S3: begin
                if (!in1)
                    next_state = S0;
                else
                    next_state = S2;
            end
            default: next_state = S0;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b0;
            S2: out = 1'b1;
            S3: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
```