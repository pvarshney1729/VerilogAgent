[BEGIN]
```verilog
module TopModule (
    input logic [4:0] a,
    input logic [4:0] b,
    input logic [4:0] c,
    input logic [4:0] d,
    input logic [4:0] e,
    input logic [4:0] f,
    output logic [7:0] w,
    output logic [7:0] x,
    output logic [7:0] y,
    output logic [7:0] z
);

    logic [31:0] concatenated_inputs;

    always @(*) begin
        concatenated_inputs = {a, b, c, d, e, f, 2'b11};
        w = concatenated_inputs[7:0];
        x = concatenated_inputs[15:8];
        y = concatenated_inputs[23:16];
        z = concatenated_inputs[31:24];
    end

endmodule
```
[DONE]