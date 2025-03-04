module TopModule(
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    output logic Q
);

    // Initialize Q to 0
    initial begin
        Q = 1'b0;
    end

    // Sequential logic for shift register stage
    always_ff @(posedge clk) begin
        if (L) begin
            Q <= R; // Load R into Q
        end else if (E) begin
            Q <= w; // Shift w into Q
        end
        // If neither L nor E are asserted, Q retains its value
    end

endmodule