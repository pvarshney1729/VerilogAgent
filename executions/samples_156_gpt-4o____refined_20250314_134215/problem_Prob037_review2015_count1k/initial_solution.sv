[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [9:0] q
);

    logic [9:0] counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'd0;
        end else if (counter == 10'd999) begin
            counter <= 10'd0;
        end else begin
            counter <= counter + 10'd1;
        end
    end

    assign q = counter;

endmodule
[DONE]