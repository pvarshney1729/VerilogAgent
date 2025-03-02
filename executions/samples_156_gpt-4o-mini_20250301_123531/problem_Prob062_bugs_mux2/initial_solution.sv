module EightBit2to1Mux (
    input        sel,  
    input  logic [7:0] a,    
    input  logic [7:0] b,    
    output logic [7:0] y     
);

    assign y = (sel == 1'b0) ? a : b;

endmodule