module TopModule (
    input logic [99:0] data_in,
    output logic [99:0] data_out
);

    always @(*) begin
        integer i;
        for (i = 0; i < 100; i = i + 1) begin
            data_out[i] = data_in[99 - i];
        end
    end

endmodule