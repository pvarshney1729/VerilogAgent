```verilog
module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    always_ff @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data}; // Shift left and insert data at LSB
        end else if (count_ena) begin
            q <= q - 1; // Decrement the counter
        end
    end

endmodule
```