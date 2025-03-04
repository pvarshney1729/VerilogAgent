module TopModule (
    input logic clock,  // Clock signal, positive-edge triggered
    input logic a,      // 1-bit input signal a
    output logic p,     // 1-bit output signal p
    output logic q      // 1-bit output signal q
);

    always @(posedge clock) begin
        if (a) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
        q <= p;
    end

endmodule