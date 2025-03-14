[BEGIN]
module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;
    logic counter_zero;

    always_ff @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (!counter_zero) begin
            counter <= counter - 10'b0000000001;
        end
    end

    always @(*) begin
        counter_zero = (counter == 10'b0000000000);
        tc = counter_zero;
    end

endmodule
[DONE]