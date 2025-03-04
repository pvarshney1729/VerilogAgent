module TopModule (
    input logic [1:0] A,
    input logic [1:0] B,
    output logic z
);

    always @(*) begin
        z = (A == B);
    end

endmodule