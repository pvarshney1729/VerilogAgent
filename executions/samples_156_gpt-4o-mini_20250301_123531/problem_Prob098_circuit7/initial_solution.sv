module TopModule (
    input logic clk,  // Clock input, positive edge-triggered
    input logic a,    // Data input
    output logic q    // Data output, one-bit register
);

    initial begin
        q = 0;  // Initialize output q to 0
    end

    always @(posedge clk) begin
        if (a == 0) begin
            if (q != 1) q <= 1;  // Set q to 1 if it's not already 1
        end else begin
            q <= ~q;  // Toggle q
        end
    end

endmodule