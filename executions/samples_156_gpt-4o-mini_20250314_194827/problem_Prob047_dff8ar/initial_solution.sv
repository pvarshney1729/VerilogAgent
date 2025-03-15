module my_module (
    input logic clk,
    input logic areset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (areset == 1'b0) begin
            q <= 8'b0;
        end else begin
            q <= d;
        end
    end

endmodule