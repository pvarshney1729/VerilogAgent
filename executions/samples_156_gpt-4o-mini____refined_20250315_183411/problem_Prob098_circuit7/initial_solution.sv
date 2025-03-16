```
[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic q
);
    logic state;

    always @(posedge clk) begin
        if (a == 1'b1 && state == 1'b0) begin
            q <= 1'b1;
        end else if (a == 1'b1 && state == 1'b1) begin
            q <= 1'b0;
        end
        state <= a;
    end

    initial begin
        q = 1'b0;
        state = 1'b0; // Initialize state to avoid unknown states
    end
endmodule
[DONE]
```