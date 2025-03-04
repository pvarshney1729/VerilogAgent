module TopModule (
    input logic clk,            // Clock signal, positive edge triggered.
    input logic rst_n,          // Asynchronous active-low reset.
    input logic [7:0] in,       // 8-bit input vector.
    output logic [7:0] anyedge   // 8-bit output vector for edge detection.
);

    logic [7:0] prev_in;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            anyedge <= 8'b0;
            prev_in <= 8'b0;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule