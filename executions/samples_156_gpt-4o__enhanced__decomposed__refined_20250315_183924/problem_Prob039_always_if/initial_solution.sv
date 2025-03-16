```verilog
module TopModule (
    input wire a,       // 1-bit input
    input wire b,       // 1-bit input
    input wire sel_b1,  // 1-bit input
    input wire sel_b2,  // 1-bit input
    output wire out_assign, // 1-bit output from assign statement
    output reg out_always   // 1-bit output from procedural statement
);

    // Implement the 2-to-1 mux using an assign statement
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Implement the 2-to-1 mux using an always block
    always @(*) begin
        if (sel_b1 && sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule
```