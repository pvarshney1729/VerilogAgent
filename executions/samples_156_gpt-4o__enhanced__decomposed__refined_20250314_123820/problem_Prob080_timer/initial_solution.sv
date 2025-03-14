[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;
    logic tc_ff;

    always_ff @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc_ff <= (data == 10'b0);
        end else if (counter != 10'b0) begin
            counter <= counter - 10'd1;
            tc_ff <= (counter == 10'b1);
        end
    end

    assign tc = tc_ff;

endmodule
[DONE]