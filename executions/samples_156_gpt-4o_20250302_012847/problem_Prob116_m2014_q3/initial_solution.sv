module combinational_circuit (
    input logic [3:0] in_vector,
    output logic out_signal
);

    always @(*) begin
        case (in_vector)
            4'b0000, 4'b0001, 4'b0011, 4'b0111, 4'b1110, 4'b1111: out_signal = 1'b1;
            default: out_signal = 1'b0;
        endcase
    end

endmodule