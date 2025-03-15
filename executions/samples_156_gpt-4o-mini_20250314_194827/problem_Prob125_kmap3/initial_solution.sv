```verilog
module combinational_logic (
    input logic a,
    input logic b,
    input logic c,
    output logic y
);

    always @(*) begin
        // Implementing the logic based on the Karnaugh map
        // Assuming the don't-care conditions are handled correctly
        y = (a & ~b & c) | (a & b) | (~a & b & ~c);
    end

endmodule
```