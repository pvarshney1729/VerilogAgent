module TopModule (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else if (load) begin
            counter <= data;
            tc <= (data == 10'b0) ? 1'b1 : 1'b0;
        end else if (counter != 10'b0) begin
            counter <= counter - 1'b1;
            if (counter == 10'b1) begin
                tc <= 1'b1;
            end
        end else begin
            tc <= 1'b1; // Ensure tc remains high once asserted
        end
    end

endmodule