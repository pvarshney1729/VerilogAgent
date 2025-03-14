[BEGIN]
module TopModule (
    input logic [7:0] in,
    output logic parity
);

    always @(*) begin
        parity = ^in; // XOR reduction operator to compute even parity
    end

endmodule
[DONE]