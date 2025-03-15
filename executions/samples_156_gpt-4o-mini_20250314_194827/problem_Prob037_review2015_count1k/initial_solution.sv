module counter (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);
    logic [9:0] count;

    always @(*) begin
        if (reset) begin
            count = 10'b0;
        end else if (count < 10'd999) begin
            count = count + 10'b1;
        end else begin
            count = 10'b0;
        end
    end

    assign q = count;

endmodule