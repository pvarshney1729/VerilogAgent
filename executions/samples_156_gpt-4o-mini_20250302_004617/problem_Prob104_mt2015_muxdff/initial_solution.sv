module my_module (
    input logic L,
    input logic A,
    input logic B,
    input logic clk,
    output logic Q
);

    always @(*) begin
        Q = L ? B : A;
    end

endmodule