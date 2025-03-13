[BEGIN]
```verilog
module TopModule(
    input logic [7:0] code,
    output logic [3:0] out,
    output logic valid
);

always @(*) begin
    case (code)
        8'h45: {valid, out} = {1'b1, 4'b0000}; // Key '0'
        8'h16: {valid, out} = {1'b1, 4'b0001}; // Key '1'
        8'h1e: {valid, out} = {1'b1, 4'b0010}; // Key '2'
        8'h26: {valid, out} = {1'b1, 4'b0011}; // Key '3'
        8'h25: {valid, out} = {1'b1, 4'b0100}; // Key '4'
        8'h2e: {valid, out} = {1'b1, 4'b0101}; // Key '5'
        8'h36: {valid, out} = {1'b1, 4'b0110}; // Key '6'
        8'h3d: {valid, out} = {1'b1, 4'b0111}; // Key '7'
        8'h3e: {valid, out} = {1'b1, 4'b1000}; // Key '8'
        8'h46: {valid, out} = {1'b1, 4'b1001}; // Key '9'
        default: {valid, out} = {1'b0, 4'b0000}; // Invalid key
    endcase
end

initial begin
    out = 4'b0000;
    valid = 1'b0;
end

endmodule
```
[DONE]