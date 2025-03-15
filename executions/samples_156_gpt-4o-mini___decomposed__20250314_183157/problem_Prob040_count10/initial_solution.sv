module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] q
);

logic [3:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 4'b0000;
    end else if (counter == 4'b1001) begin
        counter <= 4'b0000;
    end else begin
        counter <= counter + 1;
    end
end

assign q = counter;

endmodule