module TopModule (
    input  logic [7:0] input_vector,
    output logic [2:0] position
);

    always @(*) begin
        casez (input_vector)
            8'b???????1: position = 3'd0;
            8'b??????10: position = 3'd1;
            8'b?????100: position = 3'd2;
            8'b????1000: position = 3'd3;
            8'b???10000: position = 3'd4;
            8'b??100000: position = 3'd5;
            8'b?1000000: position = 3'd6;
            8'b10000000: position = 3'd7;
            default:     position = 3'd0;
        endcase
    end

endmodule