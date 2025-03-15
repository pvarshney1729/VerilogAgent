module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;
    end

    always @(*) begin
        anyedge = (in ^ prev_in);
    end

endmodule