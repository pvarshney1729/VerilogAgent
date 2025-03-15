module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
    end

    always @(*) begin
        pedge = (prev_in == 8'b00000000) & (in == 8'b11111111);
    end

endmodule