module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [4:0] in1,
    input logic [4:0] in2,
    input logic [4:0] in3,
    input logic [4:0] in4,
    input logic [4:0] in5,
    input logic [4:0] in6,
    output logic [7:0] out1,
    output logic [7:0] out2,
    output logic [7:0] out3,
    output logic [7:0] out4
);

    logic [29:0] concatenated_input;
    
    always @(*) begin
        concatenated_input = {in1, in2, in3, in4, in5, in6, 2'b11};
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            out1 <= 8'b0;
            out2 <= 8'b0;
            out3 <= 8'b0;
            out4 <= 8'b0;
        end else begin
            out1 <= concatenated_input[7:0];
            out2 <= concatenated_input[15:8];
            out3 <= concatenated_input[23:16];
            out4 <= concatenated_input[29:24];
        end
    end

endmodule