module TopModule (
    input logic clk,      // Clock signal
    input logic a,        // Input signal
    output logic q        // Output signal, registered
);

    initial begin
        q = 0; // Initialize output to 0
    end

    always @(posedge clk) begin
        if (a == 0)
            q <= 1;
        else
            q <= 0;
    end

endmodule