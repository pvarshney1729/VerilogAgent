[BEGIN]
module TopModule(
    input logic p1a,
    input logic p1b,
    input logic p1c,
    input logic p1d,
    input logic p1e,
    input logic p1f,
    input logic p2a,
    input logic p2b,
    input logic p2c,
    input logic p2d,
    output logic p1y,
    output logic p2y
);

    logic and1, and2, and3, and4;
    
    always_comb begin
        and1 = p1a & p1b & p1c; // 3-input AND
        and2 = p1d & p1e & p1f; // 3-input AND
        and3 = p2a & p2b;       // 2-input AND
        and4 = p2c & p2d;       // 2-input AND
        
        p1y = and1 | and2;      // OR for p1y
        p2y = and3 | and4;      // OR for p2y
    end

endmodule
[DONE]