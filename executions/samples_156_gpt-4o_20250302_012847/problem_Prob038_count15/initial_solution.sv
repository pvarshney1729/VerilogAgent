module counter (
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 4'd0;
        end else begin
            count <= count + 4'd1;
        end
    end

endmodule