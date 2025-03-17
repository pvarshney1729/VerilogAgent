module TopModule(
    input logic [5:0] y,
    input logic w,
    output logic Y1,
    output logic Y3
);

    logic Y2, Y4;

    // Combinational logic to determine Y2 and Y4 based on the current state and input w
    always @(*) begin
        case ({y[5], y[4], y[3], y[2], y[1], y[0], w})
            8'b00000100: Y4 = 0;
            8'b00000110: Y4 = 0;
            8'b00001000: Y4 = 0;
            8'b00001010: Y4 = 0;
            8'b00010000: Y4 = 1;
            8'b00010010: Y4 = 0;
            8'b00001100: Y4 = 1;
            8'b00001111: Y4 = 0;
            8'b01000001: Y4 = 0;
            8'b01000010: Y4 = 1;
            8'b10000000: Y4 = 1;
            8'b10000010: Y4 = 0;
            default: Y4 = 0;
        endcase
    end

    // Logic for Y1 and Y3 based on the current state
    always @(*) begin
        Y1 = y[4] | y[5]; // States E and F have Y1 = 1
        Y3 = y[3];        // State D has Y3 = 1
    end

endmodule