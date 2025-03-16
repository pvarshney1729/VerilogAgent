module TopModule(
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);

    // State encoding
    localparam logic OFF = 1'b0;
    localparam logic ON  = 1'b1;

    // State register
    logic state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            OFF: next_state = (j) ? ON : OFF;
            ON:  next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            OFF: out = 1'b0;
            ON:  out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule