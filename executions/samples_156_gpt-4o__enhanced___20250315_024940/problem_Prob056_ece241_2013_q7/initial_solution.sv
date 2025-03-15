module TopModule (
    input logic clk,
    input logic j,
    input logic k,
    output logic Q
);

    // Initialize Q to 0
    always_ff @(posedge clk) begin
        if (j == 1'b0 && k == 1'b0) begin
            // Q remains unchanged
            Q <= Q; // This is valid since Qold is the current value of Q
        end
        else if (j == 1'b0 && k == 1'b1) begin
            // Reset Q to 0
            Q <= 1'b0;
        end
        else if (j == 1'b1 && k == 1'b0) begin
            // Set Q to 1
            Q <= 1'b1;
        end
        else if (j == 1'b1 && k == 1'b1) begin
            // Toggle Q
            Q <= ~Q;
        end
    end

    // Initial block for simulation purposes (initialize Q to 0)
    initial begin
        Q = 1'b0;
    end

endmodule