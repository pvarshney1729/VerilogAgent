module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic Dx, Da, Do;
    logic Qx, Qa, Qo;

    // XOR, AND, OR gate logic
    assign Qx = x ^ Dx;
    assign Qa = x & ~Da;
    assign Qo = x | ~Do;

    // D flip-flops with asynchronous reset
    always_ff @(posedge clk) begin
        Dx <= Qx;
        Da <= Qa;
        Do <= Qo;
    end

    // NOR gate for output
    assign z = ~(Dx | Da | Do);

endmodule