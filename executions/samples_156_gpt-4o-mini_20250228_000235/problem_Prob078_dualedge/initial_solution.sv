module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic q_next;

    always @(*) begin
        q_next = q; // Default to hold current state
    end

    always @(posedge clk) begin
        q_next = d; // Capture d on rising edge
    end

    always @(negedge clk) begin
        q_next = d; // Capture d on falling edge
    end

    always @(posedge clk) begin
        q <= q_next; // Update output q
    end

    initial begin
        q = 1'b0; // Initialize q to 0
    end

endmodule