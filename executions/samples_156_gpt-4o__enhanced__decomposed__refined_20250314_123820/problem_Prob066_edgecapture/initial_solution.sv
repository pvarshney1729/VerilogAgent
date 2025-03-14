[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [31:0] in,
    output logic [31:0] out
);

    logic [31:0] previous_in;

    always_ff @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
        end else begin
            for (int i = 0; i < 32; i++) begin
                if (previous_in[i] && !in[i]) begin
                    out[i] <= 1'b1;
                end else begin
                    out[i] <= out[i];
                end
            end
        end
        previous_in <= in;
    end

endmodule
[DONE]