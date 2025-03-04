module TopModule (
    input logic a, // Single bit, logic level, LSB index 0
    input logic b, // Single bit, logic level, LSB index 0
    input logic c, // Single bit, logic level, LSB index 0
    input logic d, // Single bit, logic level, LSB index 0
    output logic q // Single bit, logic level, LSB index 0
);

    always_comb begin
        q = (b & d) | (a & !b) | (c & b);
    end

endmodule