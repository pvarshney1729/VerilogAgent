```verilog
module state_machine (
    input logic clk,
    input logic reset,
    input logic [1:0] in,
    output logic [5:0] state,
    output logic out
);

    // State encoding
    typedef enum logic [5:0] {
        S0 = 6'b000001,
        S1 = 6'b000010,
        S2 = 6'b000100,
        S3 = 6'b001000,
        S4 = 6'b010000,
        S5 = 6'b100000
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in == 2'b00) ? S1 : S2;
            S1: next_state = (in == 2'b01) ? S3 : S4;
            S2: next_state = (in == 2'b10) ? S4 : S5;
            S3: next_state = (in == 2'b11) ? S0 : S1;
            S4: next_state = (in == 2'b00) ? S2 : S3;
            S5: next_state = (in == 2'b01) ? S0 : S5;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b1;
            S2: out = 1'b0;
            S3: out = 1'b1;
            S4: out = 1'b0;
            S5: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // Assign current state to output
    assign state = current_state;

endmodule
```