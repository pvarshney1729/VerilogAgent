```verilog
module TopModule (
    input logic d,    // D input for the latch
    input logic ena,  // Enable signal
    output logic q    // Output of the latch
);

initial begin
    q = 1'b0; // Initialize q to 0
end

always @(*) begin
    if (ena) begin
        q = d;  // Update q to d when ena is high
    end
    // When ena is low, q retains its previous value
end

endmodule
```