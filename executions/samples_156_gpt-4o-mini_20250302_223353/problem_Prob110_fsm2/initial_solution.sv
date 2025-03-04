module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous active-high reset
    input logic j,             // Input for state transition
    input logic k,             // Input for state transition
    output logic out           // Output, reflects state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        out <= 1'b0; // Reset to OFF state
    end else begin
        case (out)
            1'b0: out <= j ? 1'b1 : 1'b0; // OFF state transitions
            1'b1: out <= k ? 1'b0 : 1'b1; // ON state transitions
        endcase
    end
end

endmodule