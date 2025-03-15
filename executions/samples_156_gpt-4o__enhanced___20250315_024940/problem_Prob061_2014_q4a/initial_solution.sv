module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    // Sequential logic for the D flip-flop
    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load R into Q when L is asserted
        end else if (E) begin
            Q <= w; // Shift in w when E is asserted
        end
        // If neither L nor E are asserted, Q retains its previous value
    end

    // Initialize Q to 0 in simulation
    initial begin
        Q = 1'b0; // Set initial state of Q to 0
    end

endmodule