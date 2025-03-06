module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic Q1, Q2, Q3;
    logic D1, D2, D3;

    // XOR Gate Logic
    always_ff @(posedge clk) begin
        D1 <= x ^ Q1;
        Q1 <= D1;
    end

    // AND Gate Logic
    always_ff @(posedge clk) begin
        D2 <= x & ~Q2;
        Q2 <= D2;
    end

    // OR Gate Logic
    always_ff @(posedge clk) begin
        D3 <= x | ~Q3;
        Q3 <= D3;
    end

    // Output Logic
    assign z = ~(Q1 | Q2 | Q3);

endmodule