module TopModule (
    input logic clk,
    input logic reset, // Assuming a synchronous reset is added as per recommendation
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= (data == 10'b0);
        end else if (counter != 10'b0) begin
            counter <= counter - 1'b1;
            tc <= (counter == 10'b1);
        end else begin
            tc <= 1'b1;
        end
    end

endmodule