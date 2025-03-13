```
[BEGIN]  
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Set output q to 0 when reset is high
        end else begin
            q <= d; // Update output q with input d when reset is low
        end
    end

endmodule
[DONE]
```