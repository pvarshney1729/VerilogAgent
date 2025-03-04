module TopModule (
    input logic clk,
    input logic load,
    input logic reset_n,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always @(posedge clk) begin
        if (!reset_n) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= (data == 10'b0) ? 1'b1 : 1'b0;
        end else if (counter > 10'b0) begin
            counter <= counter - 10'b1;
            tc <= (counter == 10'b1) ? 1'b1 : 1'b0;
        end else begin
            tc <= 1'b0; // Ensure tc is deasserted when counter is not zero
        end
    end

endmodule