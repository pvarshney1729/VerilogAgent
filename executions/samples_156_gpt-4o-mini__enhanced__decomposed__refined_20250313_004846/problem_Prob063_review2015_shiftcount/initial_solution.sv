```verilog
module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data};  // Shift left and input data into q[0]
        end
        else if (count_ena) begin
            q <= q - 1'b1;        // Decrement q
        end
    end

    initial begin
        q = 4'b0000;            // Initialize q to 0
    end

endmodule
```