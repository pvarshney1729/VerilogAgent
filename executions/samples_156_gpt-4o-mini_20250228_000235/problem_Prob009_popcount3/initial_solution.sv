module TopModule (
    input logic [2:0] in,
    output logic [1:0] out
);

    logic [1:0] count;

    always @(*) begin
        count = 2'b00; // Initialize count
        if (in[0] == 1'b1) count = count + 2'b01;
        if (in[1] == 1'b1) count = count + 2'b01;
        if (in[2] == 1'b1) count = count + 2'b01;
    end

    assign out = count;

endmodule