module TopModule(
    input  logic [99:0] a,
    input  logic [99:0] b,
    input  logic sel,
    output logic [99:0] out
);

    // Implementing the 2-1 multiplexer logic
    always @(*) begin
        if (sel) begin
            out = b;
        end else begin
            out = a;
        end
    end

endmodule