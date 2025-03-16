module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data;
        end else if (counter > 10'b0) begin
            counter <= counter - 1'b1;
        end
    end

    assign tc = (counter == 10'b0);

endmodule