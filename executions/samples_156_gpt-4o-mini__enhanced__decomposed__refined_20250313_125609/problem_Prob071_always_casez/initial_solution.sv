[BEGIN]
module TopModule (
    input  logic [7:0] in,    // 8-bit input vector (unsigned)
    output logic [2:0] pos     // 3-bit output representing the position of the first high bit (unsigned)
);

always @(*) begin
    pos = 3'b000; // Default value for pos
    for (int i = 0; i < 8; i++) begin
        if (in[i]) begin
            pos = i[2:0]; // Set pos to the position of the first high bit
            break; // Exit the loop once the first high bit is found
        end
    end
end

endmodule
[DONE]