module TopModule (
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] lfsr;

    always @(posedge clk) begin
        if (reset) begin
            lfsr <= 5'b00001;
        end else begin
            lfsr <= {lfsr[3:1], lfsr[0] ^ lfsr[2] ^ lfsr[4]};
        end
    end

    assign q = lfsr;

endmodule