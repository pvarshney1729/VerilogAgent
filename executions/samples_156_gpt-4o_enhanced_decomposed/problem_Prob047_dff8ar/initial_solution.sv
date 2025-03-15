module TopModule(
    input logic clk,
    input logic areset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b0; // Reset output to 0
        end else begin
            q <= d; // Transfer input to output on clock edge
        end
    end

endmodule