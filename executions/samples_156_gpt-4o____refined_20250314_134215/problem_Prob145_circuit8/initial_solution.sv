[BEGIN]
module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic state, next_state;

    // State encoding
    localparam logic S0 = 1'b0;
    localparam logic S1 = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = a ? S1 : S0;
            S1: next_state = a ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clock) begin
        state <= next_state;
    end

    // Output logic
    always @(*) begin
        p = (state == S1) && a;
        q = (state == S1);
    end

endmodule
[DONE]