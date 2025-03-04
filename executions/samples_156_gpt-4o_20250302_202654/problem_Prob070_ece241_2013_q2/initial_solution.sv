module TopModule (
    input  wire [3:0] in,     // 4-bit input vector representing a 4-bit binary number
    output reg  out_sop,      // Output in minimum sum-of-products form
    output reg  out_pos       // Output in minimum product-of-sums form
);

always @(*) begin
    // Default outputs to 0
    out_sop = 1'b0;
    out_pos = 1'b0;
    
    // Check for valid input conditions
    case (in)
        4'b0010, 4'b0111, 4'b1111: begin
            out_sop = 1'b1;
            out_pos = 1'b1;
        end
        default: begin
            out_sop = 1'b0;
            out_pos = 1'b0;
        end
    endcase
end

endmodule