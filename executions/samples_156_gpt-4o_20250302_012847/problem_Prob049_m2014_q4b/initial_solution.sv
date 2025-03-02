module refined_module (
    input logic clk,
    input logic ar,  // Asynchronous reset
    output logic q
);

    always_ff @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;  // Asynchronous reset
        end else begin
            // Add synchronous logic here if needed
        end
    end

endmodule