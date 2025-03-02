module TopModule (
    input  logic [99:0] a,   
    input  logic [99:0] b,   
    input  logic        sel, 
    output logic [99:0] out  
);

always @(*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
        default: out = 100'b0; // Default case for safety
    endcase
end

endmodule