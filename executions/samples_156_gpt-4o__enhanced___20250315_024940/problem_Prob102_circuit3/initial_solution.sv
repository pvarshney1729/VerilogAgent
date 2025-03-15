module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    always @(*) begin
        q = (b & ((~c & d) | c)) | (a & ((~b & d) | (b & c)));
    end

endmodule