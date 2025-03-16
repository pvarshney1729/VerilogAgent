module TopModule (
    input logic x,
    input logic y,
    output logic z
);

always @(*) begin
    if (x == 1'b1 && y == 1'b0) begin
        z = 1'b0; // Set z to 0 when x is 1 and y is 0
    end else if (x == 1'b0 && y == 1'b1) begin
        z = 1'b0; // Set z to 0 when x is 0 and y is 1
    end else if (x == 1'b1 && y == 1'b1) begin
        z = 1'b1; // Set z to 1 when both x and y are 1
    end else begin
        z = 1'b1; // Default state when both x and y are 0
    end
end

initial begin
    z = 1'b1; // Initial state when both x and y are 0
end

endmodule