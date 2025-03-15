module TopModule(
    input logic clk,  // Clock signal
    input logic w,    // Input from the previous stage
    input logic R,    // Load value
    input logic E,    // Enable shift
    input logic L,    // Load signal
    output logic Q    // Output of this stage
);

    always_ff @(posedge clk) begin
        if (L) begin
            Q <= R;  // Load mode: load the value R
        end else if (E) begin
            Q <= w;  // Shift mode: shift in the value w
        end
        // Hold mode implicitly handled: Q retains its value when neither L nor E is asserted
    end

endmodule