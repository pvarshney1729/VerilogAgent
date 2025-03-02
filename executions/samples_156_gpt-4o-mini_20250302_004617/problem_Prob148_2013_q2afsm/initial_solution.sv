module priority_controller (
    input logic clk,
    input logic rst_n,
    input logic req0,
    input logic req1,
    input logic req2,
    output logic grant0,
    output logic grant1,
    output logic grant2
);

    // Initialize grants to zero
    always @(posedge clk) begin
        if (!rst_n) begin
            grant0 <= 1'b0;
            grant1 <= 1'b0;
            grant2 <= 1'b0;
        end else begin
            // Default grants
            grant0 <= 1'b0;
            grant1 <= 1'b0;
            grant2 <= 1'b0;

            // Priority logic: req0 > req1 > req2
            if (req0) begin
                grant0 <= 1'b1;
            end else if (req1) begin
                grant1 <= 1'b1;
            end else if (req2) begin
                grant2 <= 1'b1;
            end
        end
    end

endmodule