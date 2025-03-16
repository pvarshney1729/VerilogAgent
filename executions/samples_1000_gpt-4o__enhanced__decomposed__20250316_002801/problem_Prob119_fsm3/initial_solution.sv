module TopModule (
    input logic clk,
    input logic areset,
    input logic in,
    output logic out
);

    // State encoding
    localparam logic [1:0] A = 2'b00,
                           B = 2'b01,
                           C = 2'b10,
                           D = 2'b11;

    // State register
    logic [1:0] state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (in == 1'b0) ? A : B;
            B: next_state = (in == 1'b0) ? C : B;
            C: next_state = (in == 1'b0) ? A : D;
            D: next_state = (in == 1'b0) ? C : B;
            default: next_state = A; // Default case for safety
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A, B, C: out = 1'b0;
            D: out = 1'b1;
            default: out = 1'b0; // Default case for safety
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule