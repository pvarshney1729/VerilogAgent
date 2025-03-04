module TopModule (
    input logic clk,    // Clock signal, triggers on the positive edge
    input logic w,      // Input from the previous stage of the shift register
    input logic R,      // Value to load into the register
    input logic E,      // Enable signal for shifting
    input logic L,      // Load signal, when asserted loads R into Q
    output logic Q      // Output of the current stage
);

    always_ff @(posedge clk) begin
        if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule