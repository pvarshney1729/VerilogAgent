module revised_module (
    input logic clk,
    input logic enable,
    output logic [3:0] out
);

    // Initialize the output to zero
    initial begin
        out = 4'b0000;
    end

    always @(posedge clk) begin
        if (enable) begin
            out <= out + 1;
        end
    end

endmodule