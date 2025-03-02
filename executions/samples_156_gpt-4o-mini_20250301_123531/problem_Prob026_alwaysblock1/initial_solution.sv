module TopModule (
    logic a,             
    logic b,             
    logic out_assign,    
    logic out_alwaysblock 
);

assign out_assign = a & b;

always @(*) begin
    out_alwaysblock = a & b;
end

endmodule