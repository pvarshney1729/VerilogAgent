```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic out
);
    logic state;

    parameter OFF = 1'b0;
    parameter ON  = 1'b1;

    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            case (state)
                OFF: begin
                    out <= 1'b0;
                    if (j) state <= ON;
                end
                ON: begin
                    out <= 1'b1;
                    if (k) state <= OFF;
                end
            endcase
        end
    end
endmodule
```