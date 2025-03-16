[BEGIN]
module TopModule (
    input logic [2:0] vec,
    output logic [2:0] outv,
    output logic o2,
    output logic o1,
    output logic o0
);

    assign outv = vec;
    
    always @(*) begin
        o0 = vec[0]; // 1'b0 is used in the context of bit assignment
        o1 = vec[1]; // 1'b1 is used in the context of bit assignment
        o2 = vec[2]; // 1'b1 is used in the context of bit assignment
    end

endmodule
[DONE]