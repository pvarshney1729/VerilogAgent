```verilog
[BEGIN]
module TopModule (
    input  logic [7:0] i_data,
    output logic [7:0] o_data
);
    always @(*) begin
        o_data = {i_data[7], i_data[6], i_data[5], i_data[4], i_data[3], i_data[2], i_data[1], i_data[0]};
    end
endmodule
[DONE]
```