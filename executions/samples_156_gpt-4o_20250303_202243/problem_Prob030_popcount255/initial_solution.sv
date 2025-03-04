module TopModule (
    input logic [254:0] in,
    input logic clk,
    input logic rst_n,
    output logic [7:0] out
);

    logic [7:0] count;

    always @(*) begin
        count = 8'd0;
        for (int i = 0; i < 255; i++) begin
            count = count + in[i];
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 8'd0;
        end else begin
            out <= count;
        end
    end

endmodule