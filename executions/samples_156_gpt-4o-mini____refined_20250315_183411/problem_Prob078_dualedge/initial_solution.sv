module TopModule (
    input logic clk,
    input logic d,
    output logic q
);

    logic q_next;

    always @(*) begin
        q_next = q; // Default to hold previous value
        if (clk) begin
            q_next = d; // On rising edge, capture d
        end
    end

    always @(posedge clk) begin
        q <= q_next; // Update q on rising edge
    end

endmodule