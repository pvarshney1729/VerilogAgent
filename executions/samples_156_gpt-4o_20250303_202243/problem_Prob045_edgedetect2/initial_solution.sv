module TopModule (
    input logic clk,             // Clock signal, positive edge-triggered
    input logic reset,           // Synchronous active-high reset
    input logic [7:0] in,        // 8-bit unsigned input vector
    output logic [7:0] anyedge   // 8-bit unsigned output vector
);

    logic [7:0] prev_in; // Temporary register to store previous state of `in`

    always @(posedge clk) begin
        if (reset) begin
            anyedge <= 8'b00000000;
            prev_in <= 8'b00000000;
        end else begin
            anyedge <= (in ^ prev_in);
            prev_in <= in;
        end
    end

endmodule