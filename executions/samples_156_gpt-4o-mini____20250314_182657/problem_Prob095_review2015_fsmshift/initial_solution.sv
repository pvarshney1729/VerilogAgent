module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [1:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 2'b00;
            shift_ena <= 1'b1;
        end else if (count < 2'b11) begin
            count <= count + 2'b01;
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end

endmodule