module TopModule (
    input logic clk,
    input logic rst,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always_ff @(posedge clk) begin
        if (rst) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= (data == 10'b0);
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
            tc <= (counter == 10'b1);
        end else begin
            tc <= 1'b1;
        end
    end

endmodule