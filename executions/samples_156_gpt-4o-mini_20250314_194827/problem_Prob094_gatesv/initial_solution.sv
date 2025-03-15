module TopModule (
    input logic [3:0] in_vector,
    input logic clk,
    input logic reset,
    output logic [3:0] out_both,
    output logic [3:0] out_any,
    output logic [3:0] out_different
);

    always @(*) begin
        out_both = in_vector & 4'b1111; // Both bits are set
        out_any = in_vector | 4'b0000;  // Any bit is set
        out_different = {in_vector[3], in_vector[2], in_vector[1], in_vector[0]} ^ 
                        {in_vector[0], in_vector[1], in_vector[2], in_vector[3]}; // Different bits
    end

    always @(posedge clk) begin
        if (reset) begin
            out_both <= 4'b0000;
            out_any <= 4'b0000;
            out_different <= 4'b0000;
        end
    end

endmodule