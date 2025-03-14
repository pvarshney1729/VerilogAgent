```verilog
[BEGIN]
module TopModule (
    input logic a,              
    input logic b,              
    input logic sel_b1,         
    input logic sel_b2,         
    output logic out_assign,     
    output logic out_always      
);

always @* begin
    // Procedural implementation for out_always
    if (sel_b1 && sel_b2) 
        out_always = 1'b1; // Using explicit size for b
    else 
        out_always = 1'b0; // Using explicit size for a
end

// Assign implementation for out_assign
assign out_assign = (sel_b1 && sel_b2) ? b : a;

endmodule
[DONE]
```