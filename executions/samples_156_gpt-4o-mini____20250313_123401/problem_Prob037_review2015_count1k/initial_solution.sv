module TopModule (
    input logic clk,
    input logic reset,
    output logic [9:0] q
);

    logic [9:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0;
        end else begin
            if (counter < 10'd999) begin
                counter <= counter + 10'b1;
            end else begin
                counter <= 10'b0;
            end
        end
    end

    assign q = counter;

endmodule