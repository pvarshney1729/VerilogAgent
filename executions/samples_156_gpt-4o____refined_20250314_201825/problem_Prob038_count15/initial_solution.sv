module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [3:0] q
);

    logic [3:0] counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000;
        end else begin
            counter <= counter + 4'b0001;
        end
    end

    assign q = counter;

endmodule