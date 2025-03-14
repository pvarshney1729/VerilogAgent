module TopModule (
    input  logic [3:0] in,            // 4-bit input vector (in[0] is LSB, in[3] is MSB)
    output logic [3:0] out_both,      // 4-bit output indicating both bits are '1'
    output logic [3:0] out_any,       // 4-bit output indicating any bit is '1'
    output logic [3:0] out_different   // 4-bit output indicating bits are different
);

    // Combinational Logic
    always @(*) begin
        // Initialize outputs
        out_both = 4'b0000; 
        out_any = 4'b0000; 
        out_different = 4'b0000; 

        // Compute out_both: Check if both in[i] and in[i+1] are '1'
        out_both[0] = 1'b0; // No left neighbor for in[0]
        out_both[1] = (in[1] & in[0]); // Check in[1] and in[0]
        out_both[2] = (in[2] & in[1]); // Check in[2] and in[1]
        out_both[3] = (in[3] & in[2]); // Check in[3] and in[2]

        // Compute out_any: Check if in[i] or in[i-1] is '1'
        out_any[3] = 1'b0; // No right neighbor for in[3]
        out_any[2] = (in[2] | in[1]); // Check in[2] and in[1]
        out_any[1] = (in[1] | in[0]); // Check in[1] and in[0]
        out_any[0] = (in[0] | in[3]); // Wrap around: in[0] and in[3]

        // Compute out_different: Check if in[i] is different from in[i-1]
        out_different[0] = (in[0] != in[3]); // Wrap around check
        out_different[1] = (in[1] != in[0]);
        out_different[2] = (in[2] != in[1]);
        out_different[3] = (in[3] != in[2]);
    end

endmodule