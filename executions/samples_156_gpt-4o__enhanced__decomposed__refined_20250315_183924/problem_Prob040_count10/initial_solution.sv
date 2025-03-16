```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [3:0] q
);

    logic [3:0] count;

    // Synchronous logic for the decade counter
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000; // Reset counter to 0
        end else if (count == 4'b1001) begin
            count <= 4'b0000; // Wrap around after 9
        end else begin
            count <= count + 1'b1; // Increment counter
        end
    end

    // Assign the count to output q
    assign q = count;

endmodule
```