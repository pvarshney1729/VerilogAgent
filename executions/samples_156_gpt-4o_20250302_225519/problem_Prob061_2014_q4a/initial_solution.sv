module TopModule (
    input logic clk,     // Clock signal, positive edge triggered
    input logic w,       // Input from the previous stage of the shift register
    input logic R,       // Value to load into the register
    input logic E,       // Enable shift
    input logic L,       // Load control signal
    input logic reset,   // Synchronous reset signal
    output logic Q       // Output to the next stage of the shift register
);

    always @(posedge clk) begin
        if (reset) begin
            Q <= 1'b0;
        end else if (L) begin
            Q <= R;
        end else if (E) begin
            Q <= w;
        end
    end

endmodule