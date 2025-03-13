```verilog
[BEGIN]
module TopModule (
    input logic [1023:0] data_in,
    input logic [7:0] select,
    output logic [3:0] data_out
);

    always @(*) begin
        if (select < 8'd256) begin
            data_out = data_in[4 * select +: 4];
        end else begin
            data_out = 4'b0000; // Default case for out-of-bounds
        end
    end

endmodule
[DONE]
```