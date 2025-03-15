module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    // State variable to count clock cycles
    logic [1:0] cycle_count;

    // Always block for synchronous reset and cycle counting
    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 2'b00;   // Reset cycle counter
            shift_ena <= 1'b1;      // Enable shift for the first cycle
        end else begin
            if (cycle_count < 2'b11) begin
                cycle_count <= cycle_count + 1; // Increment counter
                shift_ena <= 1'b1;               // Continue enabling shift
            end else begin
                shift_ena <= 1'b0;               // Disable shift after 4 cycles
            end
        end
    end

endmodule