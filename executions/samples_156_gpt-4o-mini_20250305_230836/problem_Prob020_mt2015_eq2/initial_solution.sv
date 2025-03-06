module TopModule (
    input logic [1:0] A,
    input logic [1:0] B,
    output logic z
);
    always @(*) begin
        if (A == B) 
            z = 1'b1;
        else 
            z = 1'b0;
    end
endmodule