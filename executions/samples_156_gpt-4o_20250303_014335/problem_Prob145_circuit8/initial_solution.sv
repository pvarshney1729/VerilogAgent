module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

// Initial state
initial begin
    p = 1'b0;
    q = 1'b0;
end

always_ff @(posedge clock) begin
    q <= p;
    p <= a;
end

endmodule