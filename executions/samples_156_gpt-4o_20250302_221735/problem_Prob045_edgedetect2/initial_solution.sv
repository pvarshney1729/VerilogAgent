module TopModule (
    input logic clk,
    input logic rst_n,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

    logic [7:0] prev_in;

    // Sequential logic to detect edges and handle reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            anyedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            anyedge <= in ^ prev_in;
            prev_in <= in;
        end
    end

endmodule