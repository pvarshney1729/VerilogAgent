module TopModule(
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

    logic [3:0] count;

    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (count == 4'b1001) begin
            count <= 4'b0000;
        end else begin
            count <= count + 1;
        end
    end

    assign q = count;

endmodule