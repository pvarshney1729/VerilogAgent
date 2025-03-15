module TopModule(
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset, set q to 0
        end else begin
            q <= d; // Capture the value of d on the rising edge of clk
        end
    end

endmodule