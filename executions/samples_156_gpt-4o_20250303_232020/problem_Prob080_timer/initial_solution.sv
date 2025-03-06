module TopModule (
    input wire clk,
    input wire load,
    input wire [9:0] data,
    input wire reset_n,
    output reg tc
);
    reg [9:0] counter;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= 1'b0;
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
            tc <= (counter == 1);
        end
    end
endmodule