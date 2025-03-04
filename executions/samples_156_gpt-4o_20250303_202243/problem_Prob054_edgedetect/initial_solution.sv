module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            pedge <= (in & ~prev_in);
            prev_in <= in;
        end
    end

endmodule