module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Set q to zero on reset
        end else begin
            q <= d; // Transfer input d to output q
        end
    end

endmodule