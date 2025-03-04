module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] anyedge
);
    logic [7:0] prev_in;

    always @(posedge clk) begin
        if (reset) begin
            anyedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            anyedge <= (in ^ prev_in) & 8'b11111111; // Detect edges
            prev_in <= in; // Store current state
        end
    end
endmodule