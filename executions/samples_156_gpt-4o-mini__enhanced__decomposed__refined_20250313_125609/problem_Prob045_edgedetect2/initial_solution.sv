```verilog
[BEGIN]
module TopModule (
    input logic clk,           
    input logic [7:0] in,     
    output logic [7:0] anyedge  
);

logic [7:0] prev_in; 

always @(posedge clk) begin
    anyedge <= (in ^ prev_in) & 8'hFF; 
    prev_in <= in; 
end

initial begin
    anyedge = 8'b00000000; 
    prev_in = 8'b00000000; 
end

endmodule
[DONE]
```