[BEGIN]
module TopModule (
    input logic a,   // Input bit 0 (LSB)
    input logic b,   // Input bit 1
    input logic c,   // Input bit 2
    input logic d,   // Input bit 3 (MSB)
    output logic out_sop, // Output for sum-of-products
    output logic out_pos   // Output for product-of-sums
);

always @(*) begin
    out_sop = (a & ~b & ~c & d) | (a & b & c & d) | (a & b & ~c & ~d); // SOP Form for 2, 7, 15
    out_pos = (~a & ~b & ~c & ~d) | // 0
              (~a & ~b & ~c & 1'b1) | // 1
              (~a & b & ~c & ~d) | // 4
              (~a & b & c & ~d) |  // 5
              (a & ~b & ~c & d) |  // 6
              (a & b & ~c & ~d) |  // 9
              (a & b & c & ~d) |   // 10
              (a & ~b & c & d) |   // 13
              (a & b & c & d);     // 14
end

endmodule
[DONE]