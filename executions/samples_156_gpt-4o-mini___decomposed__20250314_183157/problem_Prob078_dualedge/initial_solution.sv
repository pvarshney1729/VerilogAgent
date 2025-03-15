module TopModule (
    input logic clk,
    input logic d,
    output logic q
);
    logic q_reg;

    always @(posedge clk) begin
        q_reg <= d; // Capture d on the rising edge of clk
    end

    always @(negedge clk) begin
        q_reg <= d; // Capture d on the falling edge of clk
    end

    assign q = q_reg; // Output the stored value

endmodule