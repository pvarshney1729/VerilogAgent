module TopModule (
    input logic clk,
    input logic reset,
    output logic [31:0] q
);

    logic [31:0] lfsr;

    always_ff @(posedge clk) begin
        if (reset) begin
            lfsr <= 32'h1;
        end else begin
            lfsr[31] <= lfsr[0] ^ lfsr[31];
            lfsr[30:22] <= lfsr[31:23];
            lfsr[21] <= lfsr[0] ^ lfsr[21];
            lfsr[20:2] <= lfsr[21:3];
            lfsr[1] <= lfsr[0] ^ lfsr[1];
            lfsr[0] <= lfsr[0];
        end
    end

    assign q = lfsr;

endmodule