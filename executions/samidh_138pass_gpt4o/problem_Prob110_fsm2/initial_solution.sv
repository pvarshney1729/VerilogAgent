```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (rising edge triggered)
    input logic areset,       // Asynchronous reset (active-high)
    input logic j,            // Input signal j (1-bit)
    input logic k,            // Input signal k (1-bit)
    output logic out          // Output signal out (1-bit)
);

    // State encoding
    localparam logic OFF = 1'b0;
    localparam logic ON  = 1'b1;

    logic state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
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
[DONE]
```