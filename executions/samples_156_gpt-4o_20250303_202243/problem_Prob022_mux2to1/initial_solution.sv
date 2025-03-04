module TopModule (
    input logic a,
    input logic b,
    input logic sel,
    output logic out
);
    always_comb begin
        out = sel ? b : a; // Implementing the 2-to-1 multiplexer logic
    end
endmodule