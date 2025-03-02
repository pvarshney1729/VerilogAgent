module TopModule (
    input  wire [99:0] in,          // 100-bit unsigned input vector
    output reg  [99:0] out_both,    // 100-bit unsigned output vector
    output reg  [99:0] out_any,     // 100-bit unsigned output vector
    output reg  [99:0] out_different // 100-bit unsigned output vector
);

    always @(*) begin
        integer i;
        
        // Calculate out_both
        for (i = 0; i < 99; i = i + 1) begin
            out_both[i] = in[i] & in[i+1];
        end
        out_both[99] = 1'b0;
        
        // Calculate out_any
        out_any[0] = 1'b0;
        for (i = 1; i < 100; i = i + 1) begin
            out_any[i] = in[i] | in[i-1];
        end
        
        // Calculate out_different
        for (i = 0; i < 99; i = i + 1) begin
            out_different[i] = in[i] ^ in[i+1];
        end
        out_different[99] = in[99] ^ in[0];
    end

endmodule