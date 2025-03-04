```verilog
module TopModule (
    input logic clk,
    input logic areset,
    input logic j,
    input logic k,
    output logic out
);

    logic state, next_state;

    // State encoding
    localparam logic OFF = 1'b0;
    localparam logic ON = 1'b1;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: next_state = (j) ? ON : OFF;
            ON: next_state = (k) ? OFF : ON;
            default: next_state = OFF;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == ON);
    end

endmodule
```