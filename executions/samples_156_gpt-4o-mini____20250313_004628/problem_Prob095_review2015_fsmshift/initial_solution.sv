module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b000;
        end else if (count < 3'b100) begin
            count <= count + 1'b1;
        end
    end

    assign shift_ena = (count < 3'b100);

endmodule