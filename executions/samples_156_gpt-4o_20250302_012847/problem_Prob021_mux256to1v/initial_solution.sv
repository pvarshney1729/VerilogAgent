module TopModule (
    input logic [1023:0] data_in,
    input logic [7:0] sel,
    output logic data_out
);

    always @(*) begin
        if (sel < 8'd256) begin
            data_out = data_in[sel];
        end else begin
            data_out = 1'b0; // Default value for sel > 255
        end
    end

endmodule