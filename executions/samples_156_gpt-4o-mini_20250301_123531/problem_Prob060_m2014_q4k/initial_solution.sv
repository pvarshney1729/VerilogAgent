module TopModule (
    input logic clk,
    input logic resetn,
    input logic in,
    output logic out
);
    logic [3:0] R;

    always @(posedge clk) begin
        if (!resetn) begin
            R <= 4'b0000;
        end else begin
            R <= {R[2:0], in};
        end
    end

    assign out = R[3];
endmodule