module TopModule(
    input logic clk,
    input logic rst,
    input logic d,
    output logic q
);

logic toggle;  // Toggle signal to switch between edges
logic d_pos;   // Register for posedge data capture
logic d_neg;   // Register for negedge data capture

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        toggle <= 1'b0;
        d_pos <= 1'b0;
    end else begin
        toggle <= ~toggle;  // Toggle on every posedge
        d_pos <= d;  // Capture data on posedge
    end
end

always_ff @(negedge clk or posedge rst) begin
    if (rst) begin
        d_neg <= 1'b0;
    end else begin
        d_neg <= d;  // Capture data on negedge
    end
end

always_comb begin
    if (toggle) begin
        q = d_neg;  // Output data captured on negedge
    end else begin
        q = d_pos;  // Output data captured on posedge
    end
end

endmodule